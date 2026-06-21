export async function fetchExternalLearningTopics() {
  const response = await fetch("https://jsonplaceholder.typicode.com/posts?_limit=5");

  if (!response.ok) {
    throw new Error("Unable to load API learning topics.");
  }

  const posts = await response.json();
  return posts.map((post) => ({
    id: post.id,
    title: post.title,
    summary: post.body,
    source: "JSONPlaceholder API"
  }));
}
