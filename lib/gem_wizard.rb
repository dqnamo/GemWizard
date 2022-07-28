require 'json'

class GemWizard

  #----- asking the right questions -----#
  def self.start
    file_path = File.join( File.dirname(__FILE__), 'gems.json')
    file = File.read(file_path)
    gems = JSON.parse(file)

    @pre_install_commands = []
    @post_install_commands = []

    gems.each do |gem|
      puts gem['prompt']

      next unless boolean(gets.chomp)

      gem_groups = gem['gem_groups'].join(' ') unless gem['gem_groups'].nil?
      command = "bundle add #{gem['name']} #{!gem_groups.nil? ? "--group #{gem_groups}" : nil}"
      @pre_install_commands << command

      ask_sub_prompts(gem['sub_prompts'])
    end

    gemify!
  end

  def self.ask_sub_prompts(sub_prompts)
    sub_prompts.each do |prompt|
      puts prompt['message']

      if boolean(gets.chomp)
        @pre_install_commands << prompt['pre_install_commands'] unless prompt['pre_install_commands'].nil?
        @post_install_commands << prompt['post_install_commands'] unless prompt['post_install_commands'].nil?
      end
    end
  end

  #----- where the magic happens -----#
  def self.gemify!
    @pre_install_commands.each { |command| system(command) }
    system('bundle install')
    @post_install_commands.each { |command| system(command) }
  end

  #----- helper methods -----#
  def self.boolean(string)
    return true if 'y'.casecmp(string).zero? || 'yes'.casecmp(string).zero? || 'true'.casecmp(string).zero? 

    false
  end
end
