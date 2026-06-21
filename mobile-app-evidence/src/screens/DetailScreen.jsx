import { ArrowLeft, Heart } from "lucide-react";
import { getFavorites, saveFavorites } from "../services/storage";

export function DetailScreen({ lesson, onBack }) {
  function favoriteLesson() {
    const favorites = getFavorites();
    const nextFavorites = favorites.some((item) => item.id === lesson.id)
      ? favorites
      : [...favorites, lesson];
    saveFavorites(nextFavorites);
  }

  return (
    <main className="app-screen">
      <header className="app-header">
        <button className="icon-button" aria-label="back to home" onClick={onBack}><ArrowLeft size={20} /></button>
        <strong>Lesson detail</strong>
        <button className="icon-button" aria-label="favorite lesson" onClick={favoriteLesson}><Heart size={20} /></button>
      </header>
      <section className="detail-panel">
        <p>{lesson.level} • {lesson.minutes} min</p>
        <h1>{lesson.title}</h1>
        <p>{lesson.summary}</p>
        <button onClick={favoriteLesson}>Save to Favorites</button>
      </section>
    </main>
  );
}
