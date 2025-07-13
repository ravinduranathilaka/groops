require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "visiting the index" do
    visit tasks_url
    assert_selector "h1", text: "Tasks"
  end

  test "should create task" do
    visit tasks_url
    click_on "New task"

    fill_in "Assigned on", with: @task.assigned_on
    fill_in "Assigned to", with: @task.assigned_to_id
    fill_in "Completed on", with: @task.completed_on
    fill_in "Created by", with: @task.created_by_id
    fill_in "Description", with: @task.description
    fill_in "Name", with: @task.name
    fill_in "Status", with: @task.status
    fill_in "Urgency", with: @task.urgency
    fill_in "Visible up to", with: @task.visible_up_to_id
    click_on "Create Task"

    assert_text "Task was successfully created"
    click_on "Back"
  end

  test "should update Task" do
    visit task_url(@task)
    click_on "Edit this task", match: :first

    fill_in "Assigned on", with: @task.assigned_on.to_s
    fill_in "Assigned to", with: @task.assigned_to_id
    fill_in "Completed on", with: @task.completed_on.to_s
    fill_in "Created by", with: @task.created_by_id
    fill_in "Description", with: @task.description
    fill_in "Name", with: @task.name
    fill_in "Status", with: @task.status
    fill_in "Urgency", with: @task.urgency
    fill_in "Visible up to", with: @task.visible_up_to_id
    click_on "Update Task"

    assert_text "Task was successfully updated"
    click_on "Back"
  end

  test "should destroy Task" do
    visit task_url(@task)
    accept_confirm { click_on "Destroy this task", match: :first }

    assert_text "Task was successfully destroyed"
  end
end
