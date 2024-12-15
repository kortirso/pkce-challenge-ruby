# frozen_string_literal: true

require "pkce_challenge/version"
require "pkce_challenge/challenge"

module PkceChallenge
  class LengthOutOfRangeError < StandardError; end

  # Generate code challenge and verfiier
  #
  # Example:
  #   >> PkceChallenge.challenge
  #   => #<PkceChallenge::Challenge:0x00007f894f810378 @char_length=48, @code_verifier="QbS08cDO9pce~HVCKe9-UDiJoBMG8xwql4FI.Y3CIdpyJtPU", @code_challenge="HT90mmypkXgneRUVK-Ja009VvnoL-flydbEgRcTp5Yw">
  #
  # == Parameters:
  # options::
  #   A Hash containing optional arguments. Supported options
  #   can include `:char_length`
  #
  # == Returns:
  # An instance of PkceChallenge::Challenge
  #
  def self.challenge(options = {})
    PkceChallenge::Challenge.new(options)
  end

  # Validates code challenge and verfiier
  #
  # Example:
  #   >> PkceChallenge.pkce_valid?(code_verifier: '', code_challenge: '')
  #   => true
  #
  # == Parameters:
  # code_verifier::
  #   A String containing code_verifier
  # code_challenge::
  #   A String containing code_challenge
  #
  # == Returns:
  # An instance of Bool
  #
  def self.pkce_valid?(code_verifier:, code_challenge:)
    PkceChallenge::Challenge.new.pkce_valid?(code_verifier: code_verifier, code_challenge: code_challenge)
  end
end
