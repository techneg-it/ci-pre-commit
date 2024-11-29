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

describe os_env('CI_CACHE_ID') do
  its('content') { should_not eq nil }
  its('content') { should_not eq '' }
  its('content') { should match /^pre-commit|/ } # rubocop:disable Lint/AmbiguousRegexpLiteral
end
