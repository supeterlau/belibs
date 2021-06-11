#!/usr/bin/env ruby
#
# string_calculator_spec.rb
# Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
#
# Distributed under terms of the MIT license.
#


require 'string_calculator'

describe StringCalculator do
  
  describe '.add' do
    context 'given an empty string' do
      it 'returns zero' do
        expect(StringCalculator.add('')).to eq(0)
      end
    end
  end

end
