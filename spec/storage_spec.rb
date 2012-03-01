require File.expand_path('../spec', __FILE__)

describe Padrino::Flash::Storage do
  let :flash do
    Padrino::Flash::Storage.new(session[:_flash])
  end

  before do
    flash[:one] = 'One'
    flash[:two] = 'Two'
  end

  context :delete do
    it 'should remove the message from the storage hash' do
      flash[:notice].should == 'Flash Notice'
      flash.delete :notice
      flash.key?(:notice).should be_false
    end

    it 'should return the value of the deleted flash' do
      flash.delete(:notice).should == 'Flash Notice'
    end
  end

  it 'can delete the entire flash' do
    flash[:notice].should == 'Flash Notice'
    flash[:success].should == 'Flash Success'
    flash.clear
    flash[:notice].should be_nil
    flash[:success].should be_nil
  end

  context :[]= do
    it 'should localize flash messages when a :symbol is used' do
      flash[:localized] = :redirected
      flash.next[:localized].should == 'Redirected'
    end

    it 'should set future flash messages' do
      flash[:future] = 'Test'
      flash[:future].should be_nil
      flash.next[:future].should == 'Test'
    end
  end

  it 'should allow you to set the present flash' do
    flash.now[:present] = 'Test'
    flash[:present].should == 'Test'
  end

  it 'can discard the entire flash' do
    flash.discard
    flash.sweep
    flash[:one].should_not == 'One'
    flash[:two].should_not == 'Two'
  end

  it 'can discard a single flash' do
    flash.discard :one
    flash.sweep
    flash[:one].should_not == 'One'
    flash[:two].should == 'Two'
  end

  it 'can keep the entire flash' do
    flash.keep
    flash.sweep
    flash[:notice].should == 'Flash Notice'
  end

  it 'can keep a single flash' do
    flash.keep :notice
    flash.sweep
    flash[:notice].should == 'Flash Notice'
    flash[:success].should_not == 'Flash Success'
  end

  context :each do
    it 'can iterate through flash messages' do
      flashes = []
      flash.each do |type, message|
        flashes << [type, message]
      end
      flashes[0].should == [:notice, 'Flash Notice']
      flashes[1].should == [:success, 'Flash Success']
    end

    it 'should allow enumeration' do
      flashes = flash.collect do |type, message|
        [type, message]
      end
      flashes[0].should == [:notice, 'Flash Notice']
      flashes[1].should == [:success, 'Flash Success']
    end
  end

  it 'can sweep up the old to make room for the new' do
    flash[:notice].should == 'Flash Notice'
    flash[:one].should be_nil
    flash.sweep
    flash[:notice].should be_nil
    flash[:one].should == 'One'
  end

  it 'can replace the current flash messages' do
    flash[:notice].should == 'Flash Notice'
    flash.replace(:error => 'Replaced')
    flash[:notice].should be_nil
    flash[:error].should == 'Replaced'
  end

  context :keys do
    it 'can return the existing flash keys' do
      flash.keys.should == [:notice, :success]
    end

    it 'should return an empty array when no flashes are set' do
      flash.clear
      flash.keys.should == []
    end
  end

  context :key? do
    it 'should return true when a flash is set' do
      flash.key?(:notice).should be_true
    end

    it 'should return false when a flash is not set' do
      flash.key?(:non_existent).should be_false
    end

    it 'should not read future flash messages' do
      flash[:future] = 'Future'
      flash.key?(:future).should be_false
    end
  end

  it 'can merge flash messages' do
    flash[:notice].should == 'Flash Notice'
    flash.update(:notice => 'Flash Success')
    flash[:notice].should == 'Flash Success'
  end
end