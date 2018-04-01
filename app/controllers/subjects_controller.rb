class SubjectsController < ApplicationController
  has_many tasks, dependent: :destroy
end
