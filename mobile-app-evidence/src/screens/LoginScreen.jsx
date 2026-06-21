import { useState } from "react";
import { getUser } from "../services/storage";

export function LoginScreen({ onLogin, onSignupLink }) {
  const [form, setForm] = useState({ email: "", password: "" });
  const [error, setError] = useState("");

  function handleLogin(event) {
    event.preventDefault();
    const storedUser = getUser();

    if (!form.email || !form.password) {
      setError("Email and password are required.");
      return;
    }

    if (!storedUser || storedUser.email !== form.email) {
      setError("No learner account matches those credentials.");
      return;
    }

    onLogin(storedUser);
  }

  return (
    <main className="auth-screen">
      <h1>Welcome back</h1>
      <form onSubmit={handleLogin}>
        <input aria-label="email" autoComplete="email" placeholder="Email" value={form.email} onChange={(event) => setForm({ ...form, email: event.target.value })} />
        <input aria-label="password" autoComplete="current-password" placeholder="Password" type="password" value={form.password} onChange={(event) => setForm({ ...form, password: event.target.value })} />
        {error && <p className="error">{error}</p>}
        <button type="submit">Login</button>
      </form>
      <button className="text-link" type="button" onClick={onSignupLink}>Need an account? Sign up</button>
    </main>
  );
}
