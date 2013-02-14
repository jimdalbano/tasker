require 'minitest_helper'

describe "Tasks integration" do
  def interesting_attributes
      # Forget the date conversion stuff (ruby/@task -vs- rfc3339/json) for now.
      # these should be enough to validate the correct object is flowing
      # through the stack.
      ["id,",
        "title",
        "description",
        "priority"]
  end

  describe "Making" do
    it "creates a task nicely" do
      task = Fabricate.build(:task)
      page.driver.post "/tasks.json", {"task" => task.attributes.slice(*interesting_attributes) }
      returned = JSON.parse(body)
      returned = returned['task'].slice(*interesting_attributes)
      returned.must_equal task.attributes.slice(*interesting_attributes)
    end
  end

  describe "Fetching" do
    before do
      @task = Fabricate(:task)
    end

    it "lists all tasks" do
      visit "/tasks.json" 
      returned = JSON.parse(body)
      returned = returned['tasks'][0].slice(*interesting_attributes)
      returned.must_equal @task.attributes.slice(*interesting_attributes)
    end

    it "lists one task" do
      visit "/tasks/#{@task.id}.json"
      returned = JSON.parse(body)
      returned = returned['task'].slice(*interesting_attributes)
      returned.must_equal @task.attributes.slice(*interesting_attributes)
    end
  end

  describe "Changing" do
    it "updates attributes" do
      task = Fabricate(:task)
      attrs = task.attributes.slice(:title, :description, :priority)
      attrs[:title] = "make sure it's different from the fabricator ;p"
      page.driver.post "/tasks/#{task.id}.json/", {"task" => attrs, :_method => 'put'}
      
      # See note in app/controllers/tasks_controller.rb #update.
      body.must_be_empty
      status_code.must_equal 204
    end

  end

  describe "Deleting" do
    it "deletes a task" do
      task = Fabricate(:task)
      attrs = {:_method => 'delete'}
      page.driver.post "/tasks/#{task.id}.json/", attrs
      body.must_be_empty
      status_code.must_equal 204
    end
  end

end
