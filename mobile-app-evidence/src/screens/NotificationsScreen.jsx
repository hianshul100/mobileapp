import { useState } from "react";

export function NotificationsScreen() {
  const [message, setMessage] = useState("");

  async function sendTestNotification() {
    if (!("Notification" in window)) {
      setMessage("Notifications are not supported in this browser.");
      return;
    }

    if (Notification.permission !== "granted") {
      await Notification.requestPermission();
    }

    if (Notification.permission === "granted") {
      new Notification("SkillForge reminder", { body: "Your daily lesson is ready." });
      setMessage("Test notification sent successfully.");
    }
  }

  return (
    <main className="app-screen">
      <header className="app-header"><strong>Notifications</strong></header>
      <section className="detail-panel">
        <h1>Learning reminders</h1>
        <p>Enable a daily reminder and send a test alert.</p>
        <button onClick={sendTestNotification}>Send test notification</button>
        {message && <p className="success">{message}</p>}
      </section>
    </main>
  );
}
