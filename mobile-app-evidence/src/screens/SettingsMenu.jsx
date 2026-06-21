import { Bell, ChevronRight, Settings, User } from "lucide-react";

export function SettingsMenu({ onOpenSettings, onOpenNotifications }) {
  return (
    <aside className="settings-menu">
      <h1>Menu</h1>
      <button><User size={18} /> Profile <ChevronRight size={18} /></button>
      <button onClick={onOpenSettings}><Settings size={18} /> Settings <ChevronRight size={18} /></button>
      <button onClick={onOpenNotifications}><Bell size={18} /> Notifications <ChevronRight size={18} /></button>
    </aside>
  );
}
