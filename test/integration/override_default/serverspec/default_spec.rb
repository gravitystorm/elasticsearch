require_relative 'spec_helper'

describe 'non-standard elasticsearch install and configure' do
  path_component = rhel? ? 'sysconfig' : 'default'

  it_behaves_like 'elasticsearch user', user: 'elasticsearch',
                                        uid: 1111,
                                        shell: '/bin/sh',
                                        group: 'bar',
                                        gid: 2222

  it_behaves_like 'elasticsearch install', dir: '/usr/local/awesome',
                                           package: 'elasticsearch',
                                           user: 'elasticsearch',
                                           group: 'bar'

  it_behaves_like 'elasticsearch configure', dir: '/usr/local/awesome',
                                            user: 'elasticsearch',
                                            group: 'bar',
                                            path_conf: '/usr/local/awesome/etc/elasticsearch',
                                            path_data: '/usr/local/awesome/var/data/elasticsearch',
                                            path_logs: '/usr/local/awesome/var/log/elasticsearch',
                                            path_sysconfig: "/etc/#{path_component}/elasticsearch-crazy",
                                            jvmopts: ['java.awt.headless', 'UseG1GC']

  it_behaves_like 'elasticsearch service', 'elasticsearch-crazy'
end

describe 'removed elasticsearch users should NOT exist' do
  describe group('deleteme') do
    it { should_not exist }
  end

  describe user('deleteme') do
    it { should_not exist }
  end
end
