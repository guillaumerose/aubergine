require File.dirname(__FILE__) + '/../test_helper'

describe Courgette::Chain do
  include Ramcrest::Is

  before do
    @fetcher = mock('fetcher')

    @processor1 = mock('processor1')
    @processor2 = mock('processor2')

    @processor1_instance = mock('processor1_instance')
    @processor2_instance = mock('processor2_instance')
    
    @processor1.stubs(:new).returns(@processor1_instance)
    @processor2.stubs(:new).returns(@processor2_instance)

    @chain = Courgette::Chain.of(@fetcher, @processor1, @processor2)
  end
  
  it "delegates responsible_of" do
    @fetcher.expects(:responsible_of).with('cisco').returns(true)
    assert_that @chain.responsible_of('cisco'), is(true)
  end

  it "use the fetcher to feed processors" do
    fetcher_instance = mock('fetcher_instance')
    fetcher_instance.expects(:fetch)
                    .returns("raw data")

    @fetcher.expects(:new).with('10.0.0.1', { 'configuration' => 'hash'})
            .returns(fetcher_instance)

    @processor1_instance.expects(:process).with("raw data")
                        .returns("process1(raw data)")

    @processor2_instance.expects(:process).with("process1(raw data)")
                        .returns("process2(process1(raw data))")
    
    assert_that @chain.apply('10.0.0.1', { 'configuration' => 'hash'}), is("process2(process1(raw data))")
  end
end
