const STORAGE_KEYS = {
  user: "skillforge.user",
  favorites: "skillforge.favorites",
  settings: "skillforge.settings"
};

export function saveUser(user) {
  localStorage.setItem(STORAGE_KEYS.user, JSON.stringify(user));
}

export function getUser() {
  return JSON.parse(localStorage.getItem(STORAGE_KEYS.user) || "null");
}

export function saveFavorites(favorites) {
  localStorage.setItem(STORAGE_KEYS.favorites, JSON.stringify(favorites));
}

export function getFavorites() {
  return JSON.parse(localStorage.getItem(STORAGE_KEYS.favorites) || "[]");
}

export function saveSettings(settings) {
  localStorage.setItem(STORAGE_KEYS.settings, JSON.stringify(settings));
}

export function getSettings() {
  return JSON.parse(
    localStorage.getItem(STORAGE_KEYS.settings) ||
      '{"dailyReminder":true,"pushAlerts":true,"theme":"system"}'
  );
}

export { STORAGE_KEYS };
