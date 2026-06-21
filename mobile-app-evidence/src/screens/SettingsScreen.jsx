import { useState } from "react";
import { getSettings, saveSettings } from "../services/storage";

export function SettingsScreen() {
  const [settings, setSettings] = useState(getSettings());

  function updateSettings(nextSettings) {
    setSettings(nextSettings);
    saveSettings(nextSettings);
  }

  return (
    <main className="app-screen">
      <header className="app-header"><strong>Settings</strong></header>
      <label className="setting-row">
        Daily reminder
        <input type="checkbox" checked={settings.dailyReminder} onChange={(event) => updateSettings({ ...settings, dailyReminder: event.target.checked })} />
      </label>
      <label className="setting-row">
        Push alerts
        <input type="checkbox" checked={settings.pushAlerts} onChange={(event) => updateSettings({ ...settings, pushAlerts: event.target.checked })} />
      </label>
      <label className="setting-row">
        Theme
        <select value={settings.theme} onChange={(event) => updateSettings({ ...settings, theme: event.target.value })}>
          <option value="system">System</option>
          <option value="light">Light</option>
          <option value="dark">Dark</option>
        </select>
      </label>
    </main>
  );
}
