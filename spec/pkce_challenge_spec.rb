# frozen_string_literal: true

require "spec_helper"

RSpec.describe PkceChallenge do
  describe "#challenge" do
    let(:challenge) { PkceChallenge.challenge }

    it "should be an instance of Challenge" do
      expect(challenge).to be_an_instance_of(PkceChallenge::Challenge)
    end

    it "should have verifier with default char length" do
      expect(challenge.code_verifier.length).to equal(48)
    end

    it "should match ABNF described in [RFC 7636](https://tools.ietf.org/html/rfc7636)" do
      max_length_challenge = PkceChallenge.challenge(char_length: 128)
      min_length_challenge = PkceChallenge.challenge(char_length: 43)

      expect(challenge.code_verifier).to match(/^([A-Za-z0-9]|\-|\.|_|~){43,128}$/)
      expect(max_length_challenge.code_verifier).to match(/^([A-Za-z0-9]|\-|\.|_|~){43,128}$/)
      expect(min_length_challenge.code_verifier).to match(/^([A-Za-z0-9]|\-|\.|_|~){43,128}$/)
    end

    it "should raise an error when invalid length is given" do
      invalid = PkceChallenge.challenge(char_length: 1)
      expect { invalid.code_verifier }.to raise_error(PkceChallenge::LengthOutOfRangeError)
    end
  end

  describe "#pkce_valid?" do
    let(:challenge) { PkceChallenge.challenge }

    it "should returns true/false based on provided data" do
      code_challenge = challenge.code_challenge
      code_verifier = challenge.verifier

      expect(PkceChallenge.pkce_valid?(code_verifier: code_verifier, code_challenge: code_challenge)).to be_truthy
      expect(PkceChallenge.pkce_valid?(code_verifier: code_verifier, code_challenge: 'random')).to be_falsy
    end
  end
end
