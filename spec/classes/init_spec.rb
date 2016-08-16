require 'spec_helper'
describe 'nagios' do
  let :facts do
    {
      :id                     => 'root',
      :kernel                 => 'Linux',
      :lsbdistcodename        => 'squeeze',
      :osfamily               => 'RedHat',
      :operatingsystem        => 'centos',
      :operatingsystemrelease => '7',
      :path                   => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      :concat_basedir         => '/dne',
      :is_pe                  => false,
    }
  end

  context 'with default values for all parameters' do
    it { should contain_class('nagios') }
  end
end
