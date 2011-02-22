require 'spec_helper'

describe Remote::Host do
  before(:all) do
    File.unlink(config[:ssh])
  end

  let(:host_string) { "febuiles@ci.stackbuilders.com"}
  let(:host) { Remote::Host.new("stackbuilders", host_string) }

  describe ".add" do
    before(:all) do
      Remote::Host.add("stackbuilders", host_string, config[:ssh])
    end

    let(:conf) { Net::SSH::Config.for("stackbuilders") }

    it "adds the host to ~/.ssh/config" do
      conf[:host_name].should == "ci.stackbuilders.com"
      conf[:user].should == "febuiles"
    end

    it "doesn't overwrite existing hosts" do
      lambda {
        Remote::Host.add("stackbuilders", host_string, config[:ssh])
      }.should raise_error(Net::SSH::Exception)
    end
  end

  describe ".remove"
  describe ".get"

  describe ".new" do
    it "creates a new Host" do
      lambda {
        Remote::Host.new('name', 'someone@some_host')
      }.should_not raise_error
    end

    it "receives the config file as an optional third parameter" do
      lambda {
        Remote::Host.new('name', 'someone@some_host', 'some_file')
      }.should_not raise_error
    end

    it "doesn't create an entry in the config file" do
      Remote::Host.new('name', 'someone@some_host', 'some_file')
      Net::SSH::Config.for("name").should be_empty
    end
  end

  describe "#name" do
    subject { host.name }
    it { should == "stackbuilders" }
  end

  describe "#hostname" do
    subject { host.hostname }
    it { should == "ci.stackbuilders.com" }
  end

  describe "#port" do
    subject { host.port }

    context "when using the default port" do
      it { should == 22 }
    end

    context "when using a custom port" do
      before { host.port = 112 }
      it { should == 112 }
    end
  end

  describe "#user" do
    subject { host.user }
    it { should == "febuiles"}
  end
end
