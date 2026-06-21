import { useState } from "react";
import { createRoot } from "react-dom/client";
import { DetailScreen } from "./screens/DetailScreen";
import { HomeScreen, LESSONS } from "./screens/HomeScreen";
import { LoginScreen } from "./screens/LoginScreen";
import { NotificationsScreen } from "./screens/NotificationsScreen";
import { SettingsMenu } from "./screens/SettingsMenu";
import { SettingsScreen } from "./screens/SettingsScreen";
import { SignupScreen } from "./screens/SignupScreen";
import "./styles.css";

function App() {
  const [screen, setScreen] = useState("signup");
  const [selectedLesson, setSelectedLesson] = useState(LESSONS[0]);

  const routes = {
    signup: <SignupScreen onSignup={() => setScreen("home")} onLoginLink={() => setScreen("login")} />,
    login: <LoginScreen onLogin={() => setScreen("home")} onSignupLink={() => setScreen("signup")} />,
    home: <HomeScreen onOpenDetail={(lesson) => { setSelectedLesson(lesson); setScreen("detail"); }} onOpenSettings={() => setScreen("menu")} />,
    detail: <DetailScreen lesson={selectedLesson} onBack={() => setScreen("home")} />,
    menu: <SettingsMenu onOpenSettings={() => setScreen("settings")} onOpenNotifications={() => setScreen("notifications")} />,
    settings: <SettingsScreen />,
    notifications: <NotificationsScreen />
  };

  return <div className="phone-shell">{routes[screen]}</div>;
}

createRoot(document.getElementById("root")).render(<App />);
