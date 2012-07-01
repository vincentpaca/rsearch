require 'spec_helper'

describe RSearch do
  it "should return data when searching Google" do
    google = RSearch::Google.new("AIzaSyDZB5i7lI5t93u8sLM_-yNdz5OSrFqKUsU", "014249668475727183407:rf780m7ml6g")
    search = google.search("foo bar")
    search.results.should_not be_nil
  end
 
end
