document.querySelectorAll(".copy-btn").forEach(btn => {
    btn.addEventListener("click", async () => {
        const code = document.getElementById(btn.dataset.target);
        try {
            await navigator.clipboard.writeText(code.textContent);
            const original = btn.textContent;
            btn.textContent = "Copied!";
            setTimeout(() => {
                btn.textContent = original;
            }, 1500);
        } catch (err) {
            // Clipboard API unavailable; nothing to fall back to.
        }
    });
});
