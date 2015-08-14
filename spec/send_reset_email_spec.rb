require_relative '../lib/send_reset_email'

describe SendResetEmail do

  let(:user) { double :user, password_token: '4nknkj34nkj23n4j32', email: "user@example.com" }
  subject { described_class.new(user) }

  it 'passes a recovery message to an email client' do
    mock_rest_client = double :mock_rest_client
    allow(described_class).to receive(:get_rest) { mock_rest_client }
    expect(mock_rest_client).to receive(:post)
    described_class.call(user)
  end


end