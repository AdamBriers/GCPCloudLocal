output "topic_id" {
  description = "ID of the topic."
  value       = google_pubsub_topic.this.id
}

output "subscription_id" {
  description = "ID of the subscription."
  value       = google_pubsub_subscription.this.id
}