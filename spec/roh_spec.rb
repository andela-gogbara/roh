require "spec_helper"

APP_ROOT ||= __dir__ + "/hyperloop"

describe Roh do
  it "has a version number" do
    expect(Roh::VERSION).not_to be nil
  end
end

HyperloopApplication = Hyperloop::Application.new

describe "Hyperloop App" do
  def app
    require "hyperloop/config/routes.rb"
    HyperloopApplication
  end

  after(:all) do
    Todo.destroy_all
  end

  describe "GET index" do
    context "when making valid get request" do
      it "returns a list of all my todos" do
        get "/todo/index"
        expect(last_request.url).to eq "http://example.org/todo/index"
      end
    end
  end

  describe "GET show" do
    context "when making a valid show request" do
      before(:all) do
        @todo = create(:todo)
        get "/todo/#{@todo.id}/show"
      end
      it "return the correct url" do
        expect(last_request.path_info).to eq(
          "/todo/#{@todo.id}/show"
        )
      end

      it "returns a valid response" do
        expect(last_response.ok?).to eq true
      end
    end
  end

  describe "POST create" do
    context "when making a valid create request" do
      before(:all) do
        post(
          "/todo/create",
          todo: { title: "New Todo", body: "Write New", status: "completed" }
        )
        follow_redirect!
      end

      it "returns a valid response" do
        expect(last_response.ok?).to eq true
      end

      it "redirects to homepage" do
        expect(last_request.path_info).to eq "/"
      end
    end
  end

  describe "PUT update" do
    context "when updating todo with valid data" do
      before(:all) do
        @todo = create(:todo)
        put(
          "/todo/update",
          "id" => @todo.id,
          todo: { title: "New Todo", body: "Write New", status: "completed" }
        )
        follow_redirect!
      end

      it "returns a valid response" do
        expect(last_response.ok?).to eq true
      end

      it "redirects to todo page" do
        expect(last_request.path_info).to eq "/todo/#{@todo.id}/show"
      end
    end
  end

  describe "DELETE destroy" do
    context "when deleting a valid todo" do
      it "decreases the number of todos by 1" do
        todo = Todo.last
        expect do
          delete "/todo/#{todo.id}/destroy"
        end.to change(Todo, :count).by(-1)
      end
    end
  end
end
