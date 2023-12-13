# frozen_string_literal: true

describe file('/usr/local/bin/pre-commit') do
  it { should exist }
end

describe command('pre-commit --version') do
  its('exit_status') { should eq 0 }
end

describe command('pre-commit install-hooks') do
  its('exit_status') { should eq 0 }
end
