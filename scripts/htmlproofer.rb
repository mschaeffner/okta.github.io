#!/usr/bin/env ruby

require 'html-proofer'

# Ruby hack to convert params to boolean
extensions = true
if ARGV[0] == 'false'
    extensions = false
end

options = {
    :assume_extension => extensions,
    :allow_hash_href => true,
    :empty_alt_ignore => true,
    :log_level => :error,
    :only_4xx => true,
    # 8 threads, any more doesn't seem to make a difference
    :parallel => { :in_processes => 8},
    :file_ignore => [
        /3rd_party_notices/,
        # generated sdk docs
        /java_api_sdk/,
        /python_api_sdk/,
        /javadoc/,
        /csharp_api_sdk/
    ],
    :url_ignore => [
        /linkedin.com/, # linked in doesn't play nice with site crawlers
        /stormpath.com/, # 😢
        /\/quickstart\/#.*/ # /quickstart/#/
    ]
}
HTMLProofer.check_directory('dist', options).run
