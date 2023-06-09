# frozen_string_literal: true

module ExchangeIt
  class Account
    include ExchangeIt::Utils::Uid
    include ExchangeIt::ApiOld::Converter

    attr_reader :uid, :balance

    def initialize(user)
      @uid = hash user.name, user.surname
      @balance = 0
    end

    def transfer(receiver, amount)
      withdraw(amount)
      receiver.deposit(amount)
    end

    def transfer_with_conversion(receiver, amount, in_currency, out_currency)
      coverted_amount = convert(sum: amount, from: in_currency, to: out_currency)

      withdraw(amount)
      receiver.deposit(coverted_amount)
    end  

    def withdraw(amount)
      raise ExchangeIt::IncorrectSum, 'Amount must be positive!' unless amount.positive?
      raise ExchangeIt::NotEnoughFunds, "Available: #{@balance} dut tried to withdraw #{amount}" if amount > @balance

      @balance -= amount
    end

    def deposit(amount)
      raise ExchangeIt::IncorrectSum, 'Amount must be positive!' unless amount.positive?

      @balance += amount
    end
  end
end
