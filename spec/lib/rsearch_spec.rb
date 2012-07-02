require 'spec_helper'

describe RSearch do
  it "should return data when searching Google" do
    google = RSearch::Google.new("AIzaSyDZB5i7lI5t93u8sLM_-yNdz5OSrFqKUsU", "014249668475727183407:rf780m7ml6g")
    search = google.search("foo bar")
    search.kind.should_not be_nil
    search.url.should_not be_nil
    search.queries.should_not be_nil
    search.context.should_not be_nil
    search.items.should_not be_nil
    search.url.type.should_not be_nil
  end
 
end
