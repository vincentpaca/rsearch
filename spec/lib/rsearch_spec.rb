require 'spec_helper'

describe RSearch do
  it "should return data when searching Google" do
    google = RSearch::Google.new("AIzaSyDZB5i7lI5t93u8sLM_-yNdz5OSrFqKUsU", "014249668475727183407:rf780m7ml6g")
    search = google.search("ruby on rails")
    search.url.should_not be_nil
    search.queries.should_not be_nil
    search.context.should_not be_nil
    search.items.should_not be_nil

    search.url.type.should_not be_nil
    search.url.template.should_not be_nil
    search.queries.nextPage.should_not be_nil
    search.queries.request.should_not be_nil
    search.context.title.should_not be_nil
    search.items.count.should == 10
    search.items[0].kind.should_not be_nil
    search.items[0].title.should_not be_nil
    search.items[0].htmlTitle.should_not be_nil
    search.items[0].link.should_not be_nil
    search.items[0].displayLink.should_not be_nil
    search.items[0].snippet.should_not be_nil
    search.items[0].htmlSnippet.should_not be_nil
  end

  it "should return the correct number of results when results param is specified" do
    google = RSearch::Google.new("AIzaSyDZB5i7lI5t93u8sLM_-yNdz5OSrFqKUsU", "014249668475727183407:rf780m7ml6g")
    search = google.search("ruby on rails", { "start" => "1", "num" => "10" })
    search.url.should_not be_nil
    search.queries.should_not be_nil
    search.context.should_not be_nil
    search.items.should_not be_nil

    search.items.count.should == 10
  end
 
end
