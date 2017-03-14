require 'kitchen'
require 'kitchen/provisioner/puppet_apply'

module Kitchen
  module Provisioner
    class PuppetHierawriterApply < PuppetApply
      default_config :hiera_writer_files, nil

      def hiera_writer
        config[:hiera_writer_files]
      end

      def prepare_hiera_data
        return unless hiera_data
        info('Preparing hiera data')
        tmp_hiera_dir = File.join(sandbox_path, 'hiera')
        debug("Copying hiera data from #{hiera_data} to #{tmp_hiera_dir}")
        FileUtils.mkdir_p(tmp_hiera_dir)
        FileUtils.cp_r(Dir.glob("#{hiera_data}/*"), tmp_hiera_dir)
        if hiera_writer
          hiera_writer.each do |file|
            file.each do |filename, hiera_hash|
              debug("Creating hiera yaml file #{tmp_hiera_dir}/#{filename.to_s}")
              dir = File.join(tmp_hiera_dir, File.dirname(filename.to_s))
              FileUtils.mkdir_p(dir)
              output_file = open(File.join(dir, File.basename(filename.to_s)), 'w')
              # convert json and back before converting to yaml to recursively convert symbols to strings, heh
              output_file.write JSON[hiera_hash.to_json].to_yaml
              output_file.close
            end
          end
        end
        return unless hiera_eyaml_key_path
        tmp_hiera_key_dir = File.join(sandbox_path, 'hiera_keys')
        debug("Copying hiera eyaml keys from #{hiera_eyaml_key_path} to #{tmp_hiera_key_dir}")
        FileUtils.mkdir_p(tmp_hiera_key_dir)
        FileUtils.cp_r(Dir.glob("#{hiera_eyaml_key_path}/*"), tmp_hiera_key_dir)
      end
    end
  end
end
