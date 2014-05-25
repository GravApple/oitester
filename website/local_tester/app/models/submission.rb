class Submission < ActiveRecord::Base
  belongs_to :problem
  belongs_to :contest

  before_save :render_code

  def loaded_result
    require 'yaml'
    YAML::load(self.details || YAML::dump({}))
  end

  def judge
    require 'socket'
    require 'yaml'

    self.result = 'Waiting'
    self.save

    begin
      client = TCPSocket.new BACKGROUND_HOST, BACKGROUND_PORT
    rescue
      client = nil
    end

    if client
      self.result = 'Running'
      self.save

      client.send 'put request.yaml', 0
      if client.recvfrom(4096)[0] == 'ready'
        request = YAML::dump({
          'Order' => ['test'],
          'ProblemName' =>  [self.problem.id],
          'Name' => ['default'],
          'Language' => [self.language],
          'TimeLimit' => [self.problem.time_limit],
          'MemoryLimit' => [self.problem.memory_limit],
          'OutputLimit' => [BACKGROUND_OUTPUT_LIMIT],
          'CaseNum' => [self.problem.case_num],
          'ScoreForEachCase' => [self.problem.case_score],
          'CheckMode' => ['line'],
          'Code' => [self.code]
        })
        client.send request, 0
        client.send 'EOF', 0
        client.recvfrom(4096)[0]

        if client.recvfrom(4096)[0] == 'ready'
          client.send 'get result.yaml', 0
          if client.recvfrom(4096)[0] == 'ready'
            judge_result = client.recvfrom(131072)[0]
            self.result = 'Judged'
            self.details = judge_result

            judge_result = YAML::load(judge_result)
            self.time_cost = 0
            self.memory_cost = 0
            judge_result.keys.grep(/^Case/).each do |kase|
              self.time_cost += judge_result[kase]['Time'][0].to_i
              self.memory_cost = [self.memory_cost, judge_result[kase]['Memory'][0].to_i].max
            end
          end
        end

        client.close
      else
        self.result = 'Judge_Error'
      end
    else
      self.result = 'Judge_Error'
    end

    self.save
  end

  private

  def render_code
    require 'redcarpet'
    renderer = PygmentizeHTML.new
    extensions = { fenced_code_blocks: true }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)

    self.rendered_code = redcarpet.render "~~~ #{self.language}\n#{self.code}\n~~~"
  end
end

class PygmentizeHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    require 'pygmentize'
    Pygmentize.process(code, language)
  end
end
