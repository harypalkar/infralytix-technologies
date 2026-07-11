/**
 * INFRALYTIX — Enhanced AI Network Particle System
 */
(function () {
    const canvas = document.getElementById('particleCanvas');
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    let particles = [];
    const isMobile = window.innerWidth < 768;
    const PARTICLE_COUNT = isMobile ? 60 : 120;
    const CONNECTION_DIST = 160;
    const MOUSE_RADIUS = 250;
    let mouse = { x: null, y: null };

    function resize() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }

    function createParticles() {
        particles = [];
        for (let i = 0; i < PARTICLE_COUNT; i++) {
            particles.push({
                x: Math.random() * canvas.width,
                y: Math.random() * canvas.height,
                vx: (Math.random() - 0.5) * 0.6,
                vy: (Math.random() - 0.5) * 0.6,
                radius: Math.random() * 2 + 0.8,
                pulse: Math.random() * Math.PI * 2,
                pulseSpeed: 0.02 + Math.random() * 0.03
            });
        }
    }

    function draw() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        particles.forEach((p, i) => {
            p.x += p.vx;
            p.y += p.vy;
            p.pulse += p.pulseSpeed;

            if (p.x < 0 || p.x > canvas.width) p.vx *= -1;
            if (p.y < 0 || p.y > canvas.height) p.vy *= -1;

            if (mouse.x !== null) {
                const dx = mouse.x - p.x;
                const dy = mouse.y - p.y;
                const dist = Math.sqrt(dx * dx + dy * dy);
                if (dist < MOUSE_RADIUS) {
                    const force = (MOUSE_RADIUS - dist) / MOUSE_RADIUS * 0.04;
                    p.vx -= dx * force;
                    p.vy -= dy * force;
                }
            }

            const glow = 0.5 + Math.sin(p.pulse) * 0.3;
            const r = p.radius * (1 + Math.sin(p.pulse) * 0.3);

            const gradient = ctx.createRadialGradient(p.x, p.y, 0, p.x, p.y, r * 3);
            gradient.addColorStop(0, `rgba(80, 230, 255, ${0.8 * glow})`);
            gradient.addColorStop(0.5, `rgba(0, 188, 242, ${0.4 * glow})`);
            gradient.addColorStop(1, 'rgba(0, 120, 212, 0)');

            ctx.beginPath();
            ctx.arc(p.x, p.y, r * 3, 0, Math.PI * 2);
            ctx.fillStyle = gradient;
            ctx.fill();

            ctx.beginPath();
            ctx.arc(p.x, p.y, r, 0, Math.PI * 2);
            ctx.fillStyle = `rgba(80, 230, 255, ${0.9 * glow})`;
            ctx.fill();

            for (let j = i + 1; j < particles.length; j++) {
                const p2 = particles[j];
                const dx = p.x - p2.x;
                const dy = p.y - p2.y;
                const dist = Math.sqrt(dx * dx + dy * dy);
                if (dist < CONNECTION_DIST) {
                    const alpha = (1 - dist / CONNECTION_DIST) * 0.25;
                    const lineGrad = ctx.createLinearGradient(p.x, p.y, p2.x, p2.y);
                    lineGrad.addColorStop(0, `rgba(0, 188, 242, ${alpha})`);
                    lineGrad.addColorStop(0.5, `rgba(80, 230, 255, ${alpha * 1.5})`);
                    lineGrad.addColorStop(1, `rgba(0, 120, 212, ${alpha})`);
                    ctx.beginPath();
                    ctx.moveTo(p.x, p.y);
                    ctx.lineTo(p2.x, p2.y);
                    ctx.strokeStyle = lineGrad;
                    ctx.lineWidth = 0.8;
                    ctx.stroke();
                }
            }
        });

        requestAnimationFrame(draw);
    }

    window.addEventListener('resize', () => {
        resize();
        createParticles();
    });

    document.addEventListener('mousemove', e => {
        mouse.x = e.clientX;
        mouse.y = e.clientY;
    }, { passive: true });

    document.addEventListener('mouseleave', () => {
        mouse.x = null;
        mouse.y = null;
    });

    resize();
    createParticles();
    draw();
})();
