RSpec.describe Gossip::Integration::Udp::Serializer do
  let(:directory) { Gossip::Integration::Udp::Directory.new }

  subject { described_class.new(directory) }

  it 'can be instantiated' do
    expect(subject).to be_a(described_class)
  end

  context 'given a deserialized message' do
    let(:deserializer) { Gossip::Integration::Udp::Deserializer.new(directory, 42)}

    let(:wire_message) do
      m = <<~EOS
      ping-req 192.168.19.24
      192.168.19.12 alive 1
      192.168.19.13 suspected 3
      192.168.19.14 alive 2
      192.168.19.15 alive 4
      EOS
      m.strip     
    end

    let(:message) { deserializer.deserialize('sender', wire_message) }

    let(:result) {
      subject.serialize(message)
    }

    it 'can reproduce the wire message' do
      expect(result).to eq(wire_message)
    end
  end

end
