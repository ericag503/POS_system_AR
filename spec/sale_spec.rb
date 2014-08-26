require 'spec_helper'

describe Sale do
  it { should belong_to :cashier }
end
