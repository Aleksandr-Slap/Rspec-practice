# frozen_string_literal: true

RSpec.describe ExchangeIt::User do
  let(:user) { described_class.new 'John', 'Doe' }

  it 'returns name' do
    expect(user.name).to eq('John')
  end

  it 'returns name as a string' do
    user = described_class.new nil, 'Doe'
    expect(user.name).to be_an_instance_of(String)
  end

  it 'returns surname' do
    expect(user.surname).to eq('Doe')
  end

  it 'returns surname as a string' do
    user = described_class.new 'John', nil
    expect(user.surname).to be_an_instance_of(String)
  end

  specify '#account' do
    expect(user.account).to be_an_instance_of(ExchangeIt::Account)
  end

  it 'has zero balance by default' do
    expect(user.balance).to eq(0)
  end
end
