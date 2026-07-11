package com.infralytix.service;

import com.infralytix.model.BlogPost;
import com.infralytix.model.PortfolioProject;
import com.infralytix.model.ServiceItem;
import com.infralytix.model.TechnologyItem;
import com.infralytix.model.Testimonial;
import com.infralytix.model.TrustPillar;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContentService {

    public List<TrustPillar> getTrustPillars() {
        return List.of(
                pillar("Enterprise Grade", "Built for mission-critical workloads", "fa-building-shield"),
                pillar("Customer Focused", "Your success drives every decision", "fa-handshake"),
                pillar("Modern Technology", "Cloud-native, AI-ready engineering", "fa-microchip"),
                pillar("Trusted Solutions", "Secure, scalable, compliant delivery", "fa-shield-halved")
        );
    }

    public List<ServiceItem> getServices() {
        return List.of(
                item("Enterprise Software Development", "Custom enterprise applications with Java, Spring Boot, and scalable architectures.", "fa-code", "services/enterprise-software-development.jpg"),
                item("AI Solutions", "Intelligent automation, machine learning, and AI-powered enterprise systems.", "fa-brain", "services/ai-solutions.jpg"),
                item("Cloud Engineering", "AWS and Azure architecture, migration, and cloud-native optimization.", "fa-cloud", "services/cloud-engineering.jpg"),
                item("DevOps", "CI/CD pipelines, infrastructure automation, and release engineering.", "fa-gears", "services/devops.jpg"),
                item("Platform Engineering", "Internal developer platforms that accelerate enterprise delivery.", "fa-layer-group", "services/platform-engineering.jpg"),
                item("Microservices", "Distributed systems with API-first, domain-driven design.", "fa-cubes", "services/microservices.jpg"),
                item("API Integration", "Enterprise API gateways and seamless system interoperability.", "fa-plug", "services/api-integration.jpg"),
                item("Application Modernization", "Transform legacy systems into modern cloud platforms.", "fa-rocket", "services/application-modernization.jpg"),
                item("Observability", "Grafana, Prometheus, and OpenTelemetry monitoring solutions.", "fa-chart-line", "services/observability.jpg"),
                item("Cyber Security", "Enterprise security architecture, compliance, and threat protection.", "fa-shield-halved", "services/cyber-security.jpg"),
                item("Performance Engineering", "JVM tuning, load testing, and performance optimization.", "fa-bolt", "services/performance-engineering.jpg"),
                item("Application Support", "24x7 production support for mission-critical enterprise systems.", "fa-headset", "services/application-support.jpg")
        );
    }

    public List<ServiceItem> getSolutions() {
        return List.of(
                item("Enterprise Digital Transformation", "End-to-end strategies for modernizing enterprise operations.", "fa-building", "industries/government.jpg"),
                item("Cloud Migration", "Seamless AWS and Azure migration with minimal disruption.", "fa-cloud-arrow-up", "portfolio/cloud-migration.jpg"),
                item("AI Automation", "Intelligent process automation powered by machine learning.", "fa-robot", "portfolio/ai-chatbot.jpg"),
                item("Platform Engineering", "Self-service developer platforms for enterprise teams.", "fa-layer-group", "portfolio/microservices-platform.jpg"),
                item("Monitoring Solutions", "Full-stack observability with Grafana and Prometheus.", "fa-chart-pie", "portfolio/monitoring-dashboard.jpg"),
                item("Security Hardening", "Enterprise-grade security for cloud and on-premise systems.", "fa-lock", "industries/insurance.jpg")
        );
    }

    public List<TechnologyItem> getTechnologyItems() {
        return List.of(
                tech("Java", "technologies/java.jpg"),
                tech("Spring Boot", "technologies/spring-boot.jpg"),
                tech("React", "technologies/react.jpg"),
                tech("Angular", "technologies/angular.jpg"),
                tech("Python", "technologies/python.jpg"),
                tech("AWS", "technologies/aws.jpg"),
                tech("Azure", "technologies/azure.jpg"),
                tech("Docker", "technologies/docker.jpg"),
                tech("Kubernetes", "technologies/kubernetes.jpg"),
                tech("Kafka", "technologies/kafka.jpg"),
                tech("Redis", "technologies/redis.jpg"),
                tech("Oracle", "technologies/oracle.jpg"),
                tech("MongoDB", "technologies/mongodb.jpg"),
                tech("PostgreSQL", "technologies/postgresql.jpg"),
                tech("Grafana", "technologies/grafana.jpg"),
                tech("Prometheus", "technologies/prometheus.jpg"),
                tech("OpenTelemetry", "technologies/opentelemetry.jpg"),
                tech("GitHub", "technologies/github.jpg"),
                tech("GitLab", "technologies/gitlab.jpg"),
                tech("Jenkins", "technologies/jenkins.jpg")
        );
    }

    public List<ServiceItem> getIndustries() {
        return List.of(
                item("Banking", "Secure digital banking platforms and core system modernization.", "fa-landmark", "industries/banking.jpg"),
                item("Healthcare", "Digital hospital systems and compliant healthcare solutions.", "fa-heart-pulse", "industries/healthcare.jpg"),
                item("Insurance", "Policy management, claims processing, and underwriting automation.", "fa-umbrella", "industries/insurance.jpg"),
                item("Government", "Smart city initiatives and secure e-Governance platforms.", "fa-landmark-flag", "industries/government.jpg"),
                item("Manufacturing", "Industry 4.0 factories, IoT, and supply chain intelligence.", "fa-industry", "industries/manufacturing.jpg"),
                item("Retail", "AI-powered shopping experiences and omnichannel commerce.", "fa-cart-shopping", "industries/retail.jpg"),
                item("Telecom", "5G networks and customer experience platforms.", "fa-tower-broadcast", "industries/telecom.jpg"),
                item("Education", "Digital learning platforms and campus management systems.", "fa-graduation-cap", "industries/education.jpg")
        );
    }

    public List<PortfolioProject> getPortfolioProjects() {
        return List.of(
                project("Enterprise Banking Platform", "Core banking modernization with microservices architecture.", "portfolio/enterprise-banking.jpg", "Java", "Spring Boot", "AWS"),
                project("AI Chatbot", "Intelligent customer support with NLP and enterprise integration.", "portfolio/ai-chatbot.jpg", "Python", "React", "AWS"),
                project("Cloud Migration", "Legacy to cloud migration for enterprise workloads.", "portfolio/cloud-migration.jpg", "Azure", "Kubernetes", "Docker"),
                project("Monitoring Dashboard", "Real-time observability with Grafana and Prometheus.", "portfolio/monitoring-dashboard.jpg", "Grafana", "Prometheus", "OpenTelemetry"),
                project("DevOps Automation", "End-to-end CI/CD pipeline and infrastructure as code.", "portfolio/devops-automation.jpg", "Jenkins", "GitLab", "Docker"),
                project("Microservices Platform", "Distributed platform with API gateway and event streaming.", "portfolio/microservices-platform.jpg", "Java", "Kafka", "Redis")
        );
    }

    public List<BlogPost> getLatestBlogs() {
        return List.of(
                blog("The Future of Enterprise AI", "How artificial intelligence is reshaping enterprise software delivery.", "2026-07-01", "AI", "blogs/ai.jpg"),
                blog("Cloud Migration Best Practices", "A strategic guide to successful enterprise cloud adoption.", "2026-06-15", "Cloud", "blogs/cloud.jpg"),
                blog("Java in the Enterprise", "Modern Java patterns for scalable enterprise applications.", "2026-06-10", "Java", "blogs/java.jpg"),
                blog("Spring Boot at Scale", "Building production-grade microservices with Spring Boot.", "2026-06-05", "Spring Boot", "blogs/spring-boot.jpg"),
                blog("DevOps at Scale", "Resilient CI/CD pipelines for enterprise engineering teams.", "2026-06-01", "DevOps", "blogs/devops.jpg"),
                blog("Observability Essentials", "Monitoring strategies with Grafana, Prometheus, and OpenTelemetry.", "2026-05-25", "Monitoring", "blogs/monitoring.jpg"),
                blog("Cyber Security Essentials", "Protecting enterprise infrastructure in the AI era.", "2026-05-20", "Security", "blogs/security.jpg"),
                blog("Enterprise Architecture Patterns", "Designing resilient systems for digital transformation.", "2026-05-15", "Architecture", "blogs/architecture.jpg")
        );
    }

    public List<Testimonial> getTestimonials() {
        return List.of(
                testimonial("INFRALYTIX delivered a secure, scalable banking platform that transformed our digital operations. Their enterprise engineering expertise is exceptional.", "Financial Institution"),
                testimonial("Their DevOps automation and observability solutions significantly improved our deployment reliability and system visibility.", "Healthcare Client"),
                testimonial("A professional team with deep cloud and microservices knowledge. They modernized our legacy systems with precision.", "Enterprise Client"),
                testimonial("The AI and platform engineering solutions accelerated our digital manufacturing initiatives beyond expectations.", "Manufacturing Client")
        );
    }

    public List<String> getCareerOpenings() {
        return List.of(
                "Senior Java Developer",
                "DevOps Engineer",
                "Cloud Architect",
                "Full Stack Developer",
                "AI/ML Engineer",
                "Technical Lead"
        );
    }

    private TrustPillar pillar(String title, String subtitle, String icon) {
        return TrustPillar.builder().title(title).subtitle(subtitle).icon(icon).build();
    }

    private ServiceItem item(String title, String description, String icon, String image) {
        return ServiceItem.builder().title(title).description(description).icon(icon).image(image).build();
    }

    private TechnologyItem tech(String name, String image) {
        return TechnologyItem.builder().name(name).image(image).build();
    }

    private PortfolioProject project(String title, String description, String image, String... technologies) {
        return PortfolioProject.builder()
                .title(title)
                .description(description)
                .image(image)
                .technologies(technologies)
                .build();
    }

    private BlogPost blog(String title, String excerpt, String date, String category, String image) {
        return BlogPost.builder()
                .title(title)
                .excerpt(excerpt)
                .date(date)
                .category(category)
                .image(image)
                .build();
    }

    private Testimonial testimonial(String quote, String clientType) {
        return Testimonial.builder().quote(quote).clientType(clientType).build();
    }
}
