/**
 * INFRALYTIX — Enhanced 3D Animation utilities
 */
document.addEventListener('DOMContentLoaded', function () {
    initSmoothAnchors();
    initCardTilt();
    initHeroParallax();
    initBgOrbParallax();
});

function initSmoothAnchors() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });
}

function initCardTilt() {
    if (window.matchMedia('(max-width: 1024px)').matches) return;

    const cards = document.querySelectorAll('.enterprise-card, .card-3d, .tech-card-enterprise, .pillar-card, .feature-card');
    cards.forEach(card => {
        card.addEventListener('mousemove', function (e) {
            const rect = this.getBoundingClientRect();
            const x = (e.clientX - rect.left) / rect.width - 0.5;
            const y = (e.clientY - rect.top) / rect.height - 0.5;
            this.style.transform = `perspective(900px) rotateY(${x * 8}deg) rotateX(${-y * 8}deg) translateY(-10px) translateZ(10px)`;
        });

        card.addEventListener('mouseleave', function () {
            this.style.transform = '';
        });
    });
}

function initHeroParallax() {
    const floaters = document.querySelectorAll('.hero-floater, .hero-floater-cube');
    if (!floaters.length) return;

    document.addEventListener('mousemove', e => {
        const cx = (e.clientX / window.innerWidth - 0.5) * 2;
        const cy = (e.clientY / window.innerHeight - 0.5) * 2;
        floaters.forEach((el, i) => {
            const depth = (i + 1) * 8;
            el.style.transform = `translate(${cx * depth}px, ${cy * depth}px)`;
        });
    }, { passive: true });
}

function initBgOrbParallax() {
    const orbs = document.querySelectorAll('.bg-orb');
    if (!orbs.length || window.matchMedia('(max-width: 768px)').matches) return;

    window.addEventListener('scroll', () => {
        const scroll = window.scrollY;
        orbs.forEach((orb, i) => {
            orb.style.transform = `translateY(${scroll * (0.05 + i * 0.02)}px)`;
        });
    }, { passive: true });
}
