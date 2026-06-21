import { useState } from "react";
import { saveUser } from "../services/storage";

export function SignupScreen({ onSignup, onLoginLink }) {
  const [form, setForm] = useState({ username: "", email: "", password: "" });
  const [error, setError] = useState("");

  function updateField(field, value) {
    setForm((current) => ({ ...current, [field]: value }));
  }

  function handleSignup(event) {
    event.preventDefault();

    if (!form.username || !form.email || !form.password) {
      setError("Username, email, and password are required.");
      return;
    }

    if (!form.email.includes("@")) {
      setError("Enter a valid email address.");
      return;
    }

    const user = { username: form.username, email: form.email };
    saveUser(user);
    onSignup(user);
  }

  return (
    <main className="auth-screen">
      <h1>Create account</h1>
      <form onSubmit={handleSignup}>
        <input aria-label="username" autoComplete="username" placeholder="Username" value={form.username} onChange={(event) => updateField("username", event.target.value)} />
        <input aria-label="email" autoComplete="email" placeholder="Email" value={form.email} onChange={(event) => updateField("email", event.target.value)} />
        <input aria-label="password" autoComplete="new-password" placeholder="Password" type="password" value={form.password} onChange={(event) => updateField("password", event.target.value)} />
        {error && <p className="error">{error}</p>}
        <button type="submit">Sign up</button>
      </form>
      <button className="text-link" type="button" onClick={onLoginLink}>Already have an account? Login</button>
    </main>
  );
}
