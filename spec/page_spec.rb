require 'spec_helper'

describe Page do
	let(:page){ Page.new(title: "new page", content: "hello world") }

	subject { page }

  it { should respond_to :title }
  it { should respond_to :content}

end