class Problem < ActiveRecord::Base
  mount_uploader :data, DataUploader

  has_one :solution, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_and_belongs_to_many :contests

  before_save :render_body

  def sync_data
    require 'socket'
    require 'yaml'

    begin
      client = TCPSocket.new BACKGROUND_HOST, BACKGROUND_PORT
    rescue
      client = nil
    end

    if client
      client.send "put #{self.data.file.filename}", 0
      if client.recvfrom(4096)[0] == 'ready'
        File.open(self.data.path, 'rb') do |f|
          while data = f.read(4096)
            client.send data, 0
          end
        end
        client.send 'EOF', 0

        if client.recvfrom(4096)[0] == 'ready'
          client.send 'put request.yaml', 0
          if client.recvfrom(4096)[0] == 'ready'
            request = YAML::dump({
              'Order' => ['install_problem'],
              'Name' => [self.id],
              'Package' => [self.data.file.filename]
            })
            client.send request, 0
            client.send 'EOF', 0

            if client.recvfrom(4096)[0] == 'ready'
              self.data_synced = true
              self.save
              return true
            end
          end
        end
      end
    end
    false
  end

  private

  def render_body
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)

    self.rendered_sample_input = redcarpet.render "~~~\n#{self.sample_input}\n~~~"
    self.rendered_sample_output = redcarpet.render "~~~\n#{self.sample_output}\n~~~"
  end
end
