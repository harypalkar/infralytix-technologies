package com.infralytix.service;

import com.infralytix.model.AcceleratorItem;
import com.infralytix.model.BlogPost;
import com.infralytix.model.CaseStudy;
import com.infralytix.model.ServiceItem;
import com.infralytix.model.SolutionItem;
import com.infralytix.model.TechnologyItem;
import com.infralytix.model.TrustPillar;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContentService {

    public List<TrustPillar> getTrustPillars() {
        return List.of(
                pillar("Enterprise Architecture Expertise", "Solution designs built for scale, security, and longevity", "fa-sitemap"),
                pillar("Modern Cloud Technologies", "AWS and Azure patterns for resilient digital platforms", "fa-cloud"),
                pillar("Secure by Design", "Security, compliance, and auditability from day one", "fa-shield-halved"),
                pillar("AI-Enabled Innovation", "Practical AI that accelerates decisions and automation", "fa-brain")
        );
    }

    public List<TrustPillar> getWhyChooseUs() {
        return List.of(
                pillar("Enterprise Architecture Expertise", "Seasoned architects who design systems for growth and change.", "fa-drafting-compass"),
                pillar("Modern Cloud Technologies", "Cloud-native delivery on AWS and Azure with infrastructure as code.", "fa-cloud"),
                pillar("Scalable Solutions", "Architectures that scale with demand without compromising reliability.", "fa-chart-line"),
                pillar("Secure by Design", "Threat modeling, secure SDLC, and compliance-aware engineering.", "fa-lock"),
                pillar("Agile Delivery", "Transparent sprints, measurable outcomes, and continuous feedback.", "fa-arrows-rotate"),
                pillar("Quality Engineering", "Automated testing, performance validation, and release confidence.", "fa-vial-circle-check"),
                pillar("Reusable Accelerators", "Frameworks that reduce time-to-value without locking you in.", "fa-layer-group"),
                pillar("AI-Enabled Innovation", "Document intelligence, copilots, and automation that create ROI.", "fa-robot"),
                pillar("Customer-Centric Approach", "Partnership mindset focused on your business outcomes.", "fa-handshake")
        );
    }

    public List<SolutionItem> getEnterpriseSolutions() {
        return List.of(
                solution("Customer Communication Solutions",
                        "Unify messaging, notifications, and AI-assisted support across channels.",
                        "fa-comments", "services/api-integration.jpg",
                        List.of("Business Messaging", "Customer Notifications", "Campaign Management",
                                "AI Assisted Customer Support", "Appointment Reminders", "Conversation Automation",
                                "Multi-channel Communication", "Integration APIs", "Analytics")),
                solution("Workflow Automation Solutions",
                        "Orchestrate approvals, documents, and cross-system processes with governance.",
                        "fa-diagram-project", "services/platform-engineering.jpg",
                        List.of("Business Process Automation", "Approval Workflows", "Document Routing",
                                "Notifications", "API Integration", "Data Synchronization", "Scheduling", "Reports")),
                solution("B2B Procurement Solutions",
                        "Digitize supplier collaboration from onboarding to order fulfillment.",
                        "fa-truck-fast", "industries/manufacturing.jpg",
                        List.of("Supplier Onboarding", "Buyer Portal", "RFQ Management", "Quotation Evaluation",
                                "Vendor Collaboration", "Inventory Visibility", "Order Tracking", "Analytics")),
                solution("Enterprise Resource Planning Solutions",
                        "Modular ERP capabilities tailored to your operating model — not a boxed product claim.",
                        "fa-building", "services/enterprise-software-development.jpg",
                        List.of("Finance", "CRM", "Inventory", "Procurement", "Warehouse", "Manufacturing",
                                "HR", "Payroll", "Projects", "Asset Management", "Reporting")),
                solution("Healthcare Digital Solutions",
                        "Clinical and operational platforms designed for care quality and compliance.",
                        "fa-heart-pulse", "industries/healthcare.jpg",
                        List.of("Patient Management", "Appointments", "Billing", "Laboratory", "Pharmacy",
                                "EMR Integration", "Insurance", "Analytics")),
                solution("Manufacturing Digital Solutions",
                        "Connect planning, quality, and machine data for operational visibility.",
                        "fa-industry", "industries/manufacturing.jpg",
                        List.of("Production Planning", "Quality", "Maintenance", "Inventory", "Warehouse",
                                "Machine Monitoring", "Analytics", "Forecasting")),
                solution("AI Knowledge & Search Solutions",
                        "Private enterprise search, document intelligence, and AI copilots on your data.",
                        "fa-magnifying-glass-chart", "services/ai-solutions.jpg",
                        List.of("Enterprise Search", "Document Intelligence", "Private AI Assistants",
                                "Knowledge Base", "Voice Search", "Meeting Summaries", "AI Copilot"))
        );
    }

    /** @deprecated use getEnterpriseSolutions */
    public List<ServiceItem> getSolutions() {
        return getEnterpriseSolutions().stream()
                .map(s -> item(s.getTitle(), s.getDescription(), s.getIcon(), s.getImage()))
                .toList();
    }

    public List<ServiceItem> getServices() {
        return List.of(
                item("Enterprise Software Development", "Custom applications engineered for mission-critical business processes.", "fa-code", "services/enterprise-software-development.jpg"),
                item("Java & Spring Boot Development", "Production-grade Java platforms with modern Spring Boot architectures.", "fa-mug-hot", "technologies/java.jpg"),
                item("Microservices", "Domain-driven distributed systems with API-first design.", "fa-diagram-project", "services/microservices.jpg"),
                item("API Integration", "Secure integration layers connecting enterprise systems and partners.", "fa-plug", "services/api-integration.jpg"),
                item("Cloud Migration", "Structured migration programs with risk control and cutover discipline.", "fa-cloud-arrow-up", "services/cloud-engineering.jpg"),
                item("Cloud Native Development", "Containers, Kubernetes, and cloud-native patterns for resilience.", "fa-cloud", "services/cloud-engineering.jpg"),
                item("DevOps & CI/CD", "Automated pipelines, quality gates, and release engineering.", "fa-gears", "services/devops.jpg"),
                item("Platform Engineering", "Internal developer platforms that accelerate delivery safely.", "fa-layer-group", "services/platform-engineering.jpg"),
                item("Application Modernization", "Evolve legacy systems into maintainable, cloud-ready platforms.", "fa-rocket", "services/application-modernization.jpg"),
                item("Performance Engineering", "Load testing, JVM tuning, and scalability assurance.", "fa-bolt", "services/performance-engineering.jpg"),
                item("Application Support", "Production support and reliability operations for enterprise systems.", "fa-headset", "services/application-support.jpg"),
                item("Architecture Consulting", "Reference architectures and technology roadmaps aligned to business goals.", "fa-compass-drafting", "portfolio/microservices-platform.jpg"),
                item("Technology Assessment", "Independent reviews of stack, risk, cost, and modernization options.", "fa-clipboard-check", "blogs/architecture.jpg"),
                item("AI Consulting", "Use-case discovery, data readiness, and responsible AI adoption.", "fa-brain", "services/ai-solutions.jpg"),
                item("Observability", "Metrics, logs, traces, and alerting with Grafana, Prometheus, and OpenTelemetry.", "fa-chart-line", "services/observability.jpg")
        );
    }

    public List<AcceleratorItem> getAccelerators() {
        return List.of(
                accel("Authentication Framework", "Enterprise identity patterns with SSO-ready foundations.", "fa-key"),
                accel("Notification Service", "Multi-channel notification orchestration and templates.", "fa-bell"),
                accel("Workflow Engine", "Configurable approvals and process orchestration.", "fa-diagram-project"),
                accel("Audit Framework", "Immutable audit trails for regulated environments.", "fa-file-shield"),
                accel("API Gateway Template", "Secure edge patterns for API exposure and governance.", "fa-network-wired"),
                accel("Monitoring Stack", "Opinionated observability baseline for production systems.", "fa-desktop"),
                accel("Logging Framework", "Structured logging with correlation and retention guidance.", "fa-file-lines"),
                accel("Payment Integration Framework", "Secure payment provider integration patterns.", "fa-credit-card"),
                accel("Document Management Module", "Document storage, versioning, and access controls.", "fa-folder-open"),
                accel("Reporting Framework", "Operational and executive reporting accelerators.", "fa-chart-pie")
        );
    }

    public List<ServiceItem> getIndustries() {
        return List.of(
                item("Banking", "Core modernization, digital channels, and secure transaction platforms.", "fa-landmark", "industries/banking.jpg"),
                item("Insurance", "Policy, claims, and underwriting process digitalization.", "fa-umbrella", "industries/insurance.jpg"),
                item("Healthcare", "Clinical operations, billing, and interoperable health systems.", "fa-heart-pulse", "industries/healthcare.jpg"),
                item("Government", "Citizen services, secure platforms, and e-governance programs.", "fa-landmark-flag", "industries/government.jpg"),
                item("Manufacturing", "Industry 4.0 planning, quality, and operational intelligence.", "fa-industry", "industries/manufacturing.jpg"),
                item("Retail", "Omnichannel commerce and inventory intelligence.", "fa-cart-shopping", "industries/retail.jpg"),
                item("Education", "Campus platforms, learning systems, and administration automation.", "fa-graduation-cap", "industries/education.jpg"),
                item("Telecom", "Customer experience platforms and network-aligned digital services.", "fa-tower-broadcast", "industries/telecom.jpg"),
                item("Energy", "Asset monitoring, field operations, and operational analytics.", "fa-bolt", "industries/government.jpg"),
                item("Travel", "Booking workflows, partner integrations, and customer engagement.", "fa-plane", "industries/retail.jpg"),
                item("Hospitality", "Guest experience platforms and operational automation.", "fa-hotel", "industries/retail.jpg"),
                item("Logistics", "Shipment visibility, warehouse systems, and route orchestration.", "fa-truck", "industries/manufacturing.jpg")
        );
    }

    public List<CaseStudy> getCaseStudies() {
        return List.of(
                caseStudy("Digital Banking Transformation",
                        "Illustrative scenario: a mid-size bank modernizes customer onboarding and channel services with secure microservices.",
                        "Faster onboarding journeys, stronger auditability, and a scalable digital foundation.",
                        "portfolio/enterprise-banking.jpg", "Banking",
                        "Java", "Spring Boot", "AWS", "Kafka"),
                caseStudy("Cloud Migration Program",
                        "Illustrative scenario: an enterprise migrates critical workloads to cloud with staged cutovers and observability.",
                        "Reduced infrastructure risk, improved elasticity, and clearer operational visibility.",
                        "portfolio/cloud-migration.jpg", "Enterprise",
                        "Azure", "Kubernetes", "Terraform", "Docker"),
                caseStudy("Manufacturing Automation",
                        "Illustrative scenario: a manufacturer connects planning, quality, and machine telemetry for shop-floor decisions.",
                        "Better production visibility, fewer manual handoffs, and data-driven forecasting.",
                        "industries/manufacturing.jpg", "Manufacturing",
                        "Java", "Kafka", "Grafana", "PostgreSQL"),
                caseStudy("Healthcare Digitalization",
                        "Illustrative scenario: a healthcare provider consolidates appointments, billing, and lab workflows.",
                        "Improved care coordination and streamlined administrative operations.",
                        "industries/healthcare.jpg", "Healthcare",
                        "Spring Boot", "React", "PostgreSQL", "AWS"),
                caseStudy("Workflow Automation",
                        "Illustrative scenario: a regulated organization automates approvals and document routing with audit trails.",
                        "Shorter cycle times and stronger process governance.",
                        "services/platform-engineering.jpg", "Cross-Industry",
                        "Java", "API Integration", "Redis", "PostgreSQL"),
                caseStudy("Enterprise Monitoring",
                        "Illustrative scenario: a multi-service platform adopts metrics, logs, and traces with actionable alerting.",
                        "Faster incident response and measurable reliability improvements.",
                        "portfolio/monitoring-dashboard.jpg", "Platform",
                        "Grafana", "Prometheus", "OpenTelemetry", "Elastic")
        );
    }

    /** Compatibility for existing portfolio controller naming */
    public List<CaseStudy> getPortfolioProjects() {
        return getCaseStudies();
    }

    public List<TechnologyItem> getTechnologyItems() {
        return List.of(
                tech("Java", "technologies/java.jpg"),
                tech("Spring Boot", "technologies/spring-boot.jpg"),
                tech("Kafka", "technologies/kafka.jpg"),
                tech("Redis", "technologies/redis.jpg"),
                tech("Oracle", "technologies/oracle.jpg"),
                tech("PostgreSQL", "technologies/postgresql.jpg"),
                tech("React", "technologies/react.jpg"),
                tech("Angular", "technologies/angular.jpg"),
                tech("Next.js", "technologies/react.jpg"),
                tech("Docker", "technologies/docker.jpg"),
                tech("Kubernetes", "technologies/kubernetes.jpg"),
                tech("AWS", "technologies/aws.jpg"),
                tech("Azure", "technologies/azure.jpg"),
                tech("Terraform", "technologies/docker.jpg"),
                tech("GitHub", "technologies/github.jpg"),
                tech("GitLab", "technologies/gitlab.jpg"),
                tech("Jenkins", "technologies/jenkins.jpg"),
                tech("Grafana", "technologies/grafana.jpg"),
                tech("Prometheus", "technologies/prometheus.jpg"),
                tech("Elastic", "technologies/opentelemetry.jpg"),
                tech("OpenTelemetry", "technologies/opentelemetry.jpg")
        );
    }

    public List<BlogPost> getLatestBlogs() {
        return List.of(
                blog("Enterprise Architecture Patterns That Scale", "Practical patterns for resilient digital platforms.", "2026-07-01", "Architecture", "blogs/architecture.jpg"),
                blog("Cloud Migration Without Business Disruption", "A staged approach to enterprise cloud adoption.", "2026-06-20", "Cloud", "blogs/cloud.jpg"),
                blog("AI Copilots for Knowledge Work", "How private AI assistants unlock internal expertise safely.", "2026-06-12", "AI", "blogs/ai.jpg"),
                blog("Spring Boot at Enterprise Scale", "Building production microservices with Spring Boot.", "2026-06-05", "Java", "blogs/spring-boot.jpg"),
                blog("Observability as a Delivery Discipline", "Grafana, Prometheus, and OpenTelemetry in practice.", "2026-05-28", "Observability", "blogs/monitoring.jpg"),
                blog("Workflow Automation for Regulated Teams", "Approvals, audit trails, and process governance.", "2026-05-18", "Automation", "blogs/devops.jpg"),
                blog("Secure API Integration Strategies", "Designing integration layers for partners and platforms.", "2026-05-10", "Integration", "blogs/java.jpg"),
                blog("From Accelerators to Outcomes", "How reusable frameworks shorten enterprise delivery cycles.", "2026-05-02", "Delivery", "blogs/security.jpg")
        );
    }

    public List<String> getFaqs() {
        return List.of(
                "What industries does INFRALYTIX serve?|We partner with SMEs, mid-size and large enterprises across banking, NBFCs, healthcare, government, manufacturing, retail, education, logistics, and telecom.",
                "Do you sell packaged commercial products?|We deliver enterprise solutions, technology accelerators, reference platforms, and custom software — not claims of owning third-party commercial products.",
                "How do engagements typically start?|Most clients begin with a consultation or architecture assessment, followed by a scoped proposal and delivery roadmap.",
                "Can you work with our existing systems?|Yes. Integration, modernization, and coexistence with legacy platforms are core to our delivery model.",
                "Do you provide AI consulting?|Yes — from use-case discovery and data readiness to private AI assistants and document intelligence solutions."
        );
    }

    public List<String> getCareerOpenings() {
        return List.of(
                "Senior Java Developer",
                "Cloud Architect",
                "DevOps Engineer",
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

    private SolutionItem solution(String title, String description, String icon, String image, List<String> capabilities) {
        return SolutionItem.builder().title(title).description(description).icon(icon).image(image).capabilities(capabilities).build();
    }

    private AcceleratorItem accel(String title, String description, String icon) {
        return AcceleratorItem.builder().title(title).description(description).icon(icon).build();
    }

    private TechnologyItem tech(String name, String image) {
        return TechnologyItem.builder().name(name).image(image).build();
    }

    private CaseStudy caseStudy(String title, String scenario, String outcome, String image, String industry, String... technologies) {
        return CaseStudy.builder()
                .title(title)
                .scenario(scenario)
                .outcome(outcome)
                .image(image)
                .industry(industry)
                .technologies(technologies)
                .build();
    }

    private BlogPost blog(String title, String excerpt, String date, String category, String image) {
        return BlogPost.builder().title(title).excerpt(excerpt).date(date).category(category).image(image).build();
    }
}
