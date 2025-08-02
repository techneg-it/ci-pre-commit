# frozen_string_literal: true

describe file('/usr/bin/time') do
  it { should exist }
end

describe command('time true') do
  its('exit_status') { should eq 0 }
  its('stderr') { should_not be_empty }
end
