# frozen_string_literal: true

describe file('/usr/local/bin/pre-commit') do
  it { should exist }
end
