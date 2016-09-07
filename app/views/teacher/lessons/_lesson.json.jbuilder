json.extract! lesson, :id, :title, :description
json.start lesson.start_time
json.end lesson.end_time
json.url teacher_lesson_url(lesson, format: :html)
