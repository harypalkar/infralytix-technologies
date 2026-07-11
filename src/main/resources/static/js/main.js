/**
 * INFRALYTIX TECHNOLOGIES — Enterprise JavaScript
 */

document.addEventListener('DOMContentLoaded', function () {
    initLoader();
    initNavbar();
    initMobileMenu();
    initScrollReveal();
    initParallax();
    initMouseGlow();
    initLazyImages();
});

function initLoader() {
    const loader = document.getElementById('pageLoader');
    if (!loader) return;

    const hide = () => {
        loader.classList.add('hidden');
        document.body.style.overflow = '';
    };

    if (document.readyState === 'complete') {
        setTimeout(hide, 600);
    } else {
        window.addEventListener('load', () => setTimeout(hide, 800));
    }
    setTimeout(hide, 3000);
}

function initNavbar() {
    const navbar = document.getElementById('mainNavbar');
    if (!navbar) return;

    const onScroll = () => {
        navbar.classList.toggle('scrolled', window.scrollY > 40);
    };

    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
}

function initMobileMenu() {
    const toggle = document.getElementById('navbarToggle');
    const menu = document.getElementById('navbarMenu');
    if (!toggle || !menu) return;

    toggle.addEventListener('click', () => {
        toggle.classList.toggle('active');
        menu.classList.toggle('active');
        document.body.style.overflow = menu.classList.contains('active') ? 'hidden' : '';
    });

    menu.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', () => {
            toggle.classList.remove('active');
            menu.classList.remove('active');
            document.body.style.overflow = '';
        });
    });
}

function initScrollReveal() {
    const elements = document.querySelectorAll('.animate-on-scroll');
    if (!elements.length) return;

    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

    elements.forEach(el => observer.observe(el));
}

function initParallax() {
    const heroBg = document.querySelector('.hero-enterprise-bg img');
    const pageHeroBg = document.querySelector('.page-hero-enterprise-bg img');

    if (!heroBg && !pageHeroBg) return;

    window.addEventListener('scroll', () => {
        const scroll = window.scrollY;
        if (heroBg) {
            heroBg.style.transform = `scale(1.05) translateY(${scroll * 0.15}px)`;
        }
        if (pageHeroBg) {
            pageHeroBg.style.transform = `translateY(${scroll * 0.1}px)`;
        }
    }, { passive: true });
}

function initMouseGlow() {
    if (window.matchMedia('(max-width: 1024px)').matches) return;

    const glow = document.createElement('div');
    glow.className = 'cursor-glow';
    document.body.appendChild(glow);

    let visible = false;
    document.addEventListener('mousemove', e => {
        glow.style.left = e.clientX + 'px';
        glow.style.top = e.clientY + 'px';
        if (!visible) {
            glow.style.opacity = '1';
            visible = true;
        }
    }, { passive: true });

    document.addEventListener('mouseleave', () => {
        glow.style.opacity = '0';
        visible = false;
    });
}

function initLazyImages() {
    const images = document.querySelectorAll('img[loading="lazy"]');
    images.forEach(img => {
        img.addEventListener('load', () => img.classList.add('loaded'));
        if (img.complete) img.classList.add('loaded');
    });
}
