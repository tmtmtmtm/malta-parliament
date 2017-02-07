# frozen_string_literal: true
require_relative './test_helper'
require_relative '../lib/member_page.rb'

describe MemberPage do
  describe 'Dr Albert Fenech' do
    around { |test| VCR.use_cassette('AlbertFenech', &test) }

    subject do
      url = 'http://www.parlament.mt/fenech-albert'
      MemberPage.new(response: Scraped::Request.new(url: url).response)
    end

    it 'should have a name field with the name of the member without a prefix' do
      subject.name.must_equal 'Albert Fenech'
    end

    it 'should have an honorific_prefix field' do
      subject.must_respond_to(:honorific_prefix)
    end

    it 'should store any titles in the honorific_prefix field' do
      subject.honorific_prefix.must_equal 'Dr'
    end
  end

  describe 'Ian Borg' do
    around { |test| VCR.use_cassette('IanBorg', &test) }

    subject do
      url = 'http://www.parlament.mt/borg-ian'
      MemberPage.new(response: Scraped::Request.new(url: url).response)
    end

    it 'should leave a non prefixed name unchanged' do
      subject.name.must_equal 'Ian Borg'
    end

    it 'should not return a prefix when none is present in the name' do
      subject.honorific_prefix.must_be_empty
    end
  end
end
