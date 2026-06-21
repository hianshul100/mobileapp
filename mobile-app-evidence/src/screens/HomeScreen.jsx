import { Bell, Menu, Star } from "lucide-react";

export const LESSONS = [
  { id: 1, title: "React Native Basics", level: "Beginner", minutes: 18, summary: "Build reusable components for mobile screens." },
  { id: 2, title: "Persisting Favorites", level: "Intermediate", minutes: 22, summary: "Store selected lessons with local storage." },
  { id: 3, title: "API Data UX", level: "Intermediate", minutes: 25, summary: "Fetch remote data and show loading states." }
];

export function HomeScreen({ onOpenDetail, onOpenSettings }) {
  return (
    <main className="app-screen">
      <header className="app-header">
        <button className="icon-button" aria-label="settings menu" onClick={onOpenSettings}><Menu size={20} /></button>
        <strong className="logo">SkillForge</strong>
        <Bell size={20} />
      </header>
      <section className="hero-panel">
        <p>Today</p>
        <h1>Keep your learning streak alive</h1>
      </section>
      <section className="lesson-list">
        {LESSONS.map((lesson) => (
          <article className="lesson-card" key={lesson.id}>
            <div>
              <h2>{lesson.title}</h2>
              <p>{lesson.level} • {lesson.minutes} min</p>
            </div>
            <button aria-label={`open ${lesson.title}`} onClick={() => onOpenDetail(lesson)}>
              <Star size={16} /> Details
            </button>
          </article>
        ))}
      </section>
    </main>
  );
}
