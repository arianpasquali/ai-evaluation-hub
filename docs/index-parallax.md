---
hide:
  - navigation
  - toc
---

<style>
/* Landing Page Styles */
.md-content__inner {
  margin: 0;
  padding: 0;
  max-width: none;
}

.md-content {
  margin: 0;
}

/* Hero Section */
.hero-section {
  min-height: 90vh;
  position: relative;
  display: flex;
  align-items: center;
  overflow: hidden;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 2rem 0;
}

.hero-background {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 120%;
  z-index: 1;
}

.parallax-layer {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  transition: transform 0.1s ease-out;
}

.parallax-layer:nth-child(1) {
  background: radial-gradient(circle at 20% 20%, rgba(120, 119, 198, 0.3) 0%, transparent 50%);
}

.parallax-layer:nth-child(2) {
  background: radial-gradient(circle at 80% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
}

.parallax-layer:nth-child(3) {
  background: radial-gradient(circle at 40% 40%, rgba(120, 119, 198, 0.2) 0%, transparent 50%);
}

.hero-content {
  position: relative;
  z-index: 2;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 800;
  line-height: 1.1;
  margin-bottom: 1.5rem;
  color: white;
}

.gradient-text {
  background: linear-gradient(45deg, #ffd89b 0%, #19547b 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: 1.25rem;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 2rem;
  line-height: 1.6;
}

.hero-cta {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.btn {
  padding: 0.75rem 2rem;
  border-radius: 50px;
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
  display: inline-block;
  border: 2px solid transparent;
}

.btn-primary {
  background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
  color: white;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
  color: white;
  text-decoration: none;
}

.btn-secondary {
  background: transparent;
  color: white;
  border-color: white;
}

.btn-secondary:hover {
  background: white;
  color: #667eea;
  text-decoration: none;
}

/* Floating Cards */
.hero-visual {
  position: relative;
  height: 400px;
}

.floating-card {
  position: absolute;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  padding: 1.5rem;
  animation: float 6s ease-in-out infinite;
}

.card-1 {
  top: 20%;
  left: 10%;
  animation-delay: 0s;
}

.card-2 {
  top: 50%;
  right: 20%;
  animation-delay: 2s;
}

.card-3 {
  bottom: 20%;
  left: 30%;
  animation-delay: 4s;
}

.metric-value {
  display: block;
  font-size: 2rem;
  font-weight: 800;
  color: white;
}

.metric-label {
  display: block;
  font-size: 0.875rem;
  color: rgba(255, 255, 255, 0.8);
  margin-top: 0.5rem;
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
}

/* Sections */
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.custom-section {
  padding: 5rem 0;
  position: relative;
}

.section-background {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  z-index: -1;
}

.section-background-alt {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  z-index: -1;
}

.section-header {
  text-align: center;
  margin-bottom: 4rem;
}

.section-title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: #333;
}

.section-subtitle {
  font-size: 1.125rem;
  color: #666;
}

/* Features Grid */
.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.feature-card {
  background: white;
  padding: 2rem;
  border-radius: 20px;
  text-align: center;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.feature-card:hover {
  transform: translateY(-10px);
}

.feature-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.feature-card h3 {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 1rem;
  color: #333;
}

.feature-card p {
  color: #666;
  line-height: 1.6;
}

/* Methodology Section */
.methodology-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
}

.lead {
  font-size: 1.25rem;
  color: #666;
  margin-bottom: 2rem;
}

.methodology-steps {
  margin-bottom: 2rem;
}

.step {
  display: flex;
  align-items: flex-start;
  margin-bottom: 1.5rem;
}

.step-number {
  background: linear-gradient(45deg, #667eea, #764ba2);
  color: white;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  margin-right: 1rem;
  flex-shrink: 0;
}

.step-content h4 {
  font-size: 1.125rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: #333;
}

.step-content p {
  color: #666;
  margin: 0;
}

/* Process Flow */
.diagram-container {
  background: white;
  padding: 2rem;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.process-flow {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.flow-node {
  background: #f8f9fa;
  padding: 1rem;
  border-radius: 10px;
  text-align: center;
  font-weight: 600;
  color: #666;
  transition: all 0.3s ease;
}

.flow-node.active {
  background: linear-gradient(45deg, #667eea, #764ba2);
  color: white;
}

.flow-arrow {
  width: 2px;
  height: 20px;
  background: #ddd;
  margin: 0 auto;
}

/* Pathways */
.pathways-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.pathway-card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  padding: 2rem;
  transition: transform 0.3s ease;
}

.pathway-card:hover {
  transform: translateY(-10px);
}

.pathway-header {
  text-align: center;
  margin-bottom: 1.5rem;
}

.pathway-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.pathway-card h3 {
  font-size: 1.5rem;
  font-weight: 600;
  color: white;
  margin: 0;
}

.pathway-content p {
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 1rem;
}

.pathway-features {
  list-style: none;
  padding: 0;
  margin-bottom: 1.5rem;
}

.pathway-features li {
  color: rgba(255, 255, 255, 0.8);
  margin-bottom: 0.5rem;
  padding-left: 1rem;
  position: relative;
}

.pathway-features li:before {
  content: "✓";
  position: absolute;
  left: 0;
  color: #4ecdc4;
  font-weight: 600;
}

.btn-outline {
  background: transparent;
  color: white;
  border: 2px solid white;
}

.btn-outline:hover {
  background: white;
  color: #667eea;
  text-decoration: none;
}

/* Stats Section */
.stats-section {
  background: #333;
  color: white;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 2rem;
}

.stat-item {
  text-align: center;
}

.stat-number {
  font-size: 3rem;
  font-weight: 800;
  color: #4ecdc4;
  display: block;
}

.stat-label {
  font-size: 1rem;
  color: rgba(255, 255, 255, 0.8);
  margin-top: 0.5rem;
}

/* CTA Section */
.cta-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  text-align: center;
}

.cta-content h2 {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.cta-content p {
  font-size: 1.25rem;
  margin-bottom: 2rem;
  opacity: 0.9;
}

.cta-buttons {
  display: flex;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.btn-large {
  padding: 1rem 2.5rem;
  font-size: 1.125rem;
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .hero-title {
    font-size: 2.5rem;
  }
  
  .methodology-content {
    grid-template-columns: 1fr;
  }
  
  .section-title {
    font-size: 2rem;
  }
  
  .cta-buttons {
    flex-direction: column;
    align-items: center;
  }
}

/* Animation classes */
.fade-in {
  opacity: 0;
  transform: translateY(30px);
  transition: all 0.6s ease;
}

.fade-in.visible {
  opacity: 1;
  transform: translateY(0);
}

.zoom-in {
  opacity: 0;
  transform: scale(0.8);
  transition: all 0.6s ease;
}

.zoom-in.visible {
  opacity: 1;
  transform: scale(1);
}
</style>

# Faktion AI Evaluation Hub

<div class="hero-section" id="hero">
  <div class="hero-background">
    <div class="parallax-layer" data-speed="0.2"></div>
    <div class="parallax-layer" data-speed="0.5"></div>
    <div class="parallax-layer" data-speed="0.8"></div>
  </div>
  
  <div class="hero-content">
    <div class="hero-text">
      <h1 class="hero-title">
        <span class="gradient-text">Transform AI Evaluation</span>
        <br>with Data-Driven Excellence
      </h1>
      <p class="hero-subtitle">
        Faktion's comprehensive methodology for generative AI evaluation. 
        From RAG systems to LLMs, master the art of measuring AI performance.
      </p>
      <div class="hero-cta">
        <a href="introduction/" class="btn btn-primary">Start Your Journey</a>
        <a href="introduction/evaluation-driven-methodology/" class="btn btn-secondary">Explore Methodology</a>
      </div>
    </div>
    
    <div class="hero-visual">
      <div class="floating-card card-1">
        <div class="metric">
          <span class="metric-value">98.5%</span>
          <span class="metric-label">Accuracy</span>
        </div>
      </div>
      <div class="floating-card card-2">
        <div class="metric">
          <span class="metric-value">2.3s</span>
          <span class="metric-label">Response Time</span>
        </div>
      </div>
      <div class="floating-card card-3">
        <div class="metric">
          <span class="metric-value">15+</span>
          <span class="metric-label">Active Projects</span>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="custom-section" id="features">
  <div class="section-background"></div>
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Why Choose Our Evaluation Framework?</h2>
      <p class="section-subtitle">Built from real-world experience, validated by results</p>
    </div>
    
    <div class="features-grid">
      <div class="feature-card fade-in">
        <div class="feature-icon">🎯</div>
        <h3>Precision-Focused</h3>
        <p>Multi-dimensional evaluation framework that captures every aspect of AI performance from accuracy to user experience.</p>
      </div>
      
      <div class="feature-card fade-in">
        <div class="feature-icon">🔄</div>
        <h3>Continuous Integration</h3>
        <p>Seamlessly integrate evaluation into your development workflow with automated pipelines and real-time monitoring.</p>
      </div>
      
      <div class="feature-card fade-in">
        <div class="feature-icon">🚀</div>
        <h3>Production-Ready</h3>
        <p>Battle-tested methodologies used in enterprise deployments serving millions of users worldwide.</p>
      </div>
      
      <div class="feature-card fade-in">
        <div class="feature-icon">🧠</div>
        <h3>RAG Specialized</h3>
        <p>Dedicated evaluation techniques for Retrieval-Augmented Generation systems with proven effectiveness.</p>
      </div>
      
      <div class="feature-card fade-in">
        <div class="feature-icon">📊</div>
        <h3>Data-Driven Insights</h3>
        <p>Transform evaluation results into actionable insights with comprehensive analytics and visualization tools.</p>
      </div>
      
      <div class="feature-card fade-in">
        <div class="feature-icon">🤝</div>
        <h3>Team Collaboration</h3>
        <p>Foster cross-functional collaboration with shared standards, templates, and best practices.</p>
      </div>
    </div>
  </div>
</div>

<div class="custom-section" id="methodology">
  <div class="container">
    <div class="methodology-content">
      <div class="methodology-text fade-in">
        <h2>Evaluation-Driven Development</h2>
        <p class="lead">Our revolutionary approach puts evaluation at the heart of AI development, not as an afterthought.</p>
        
        <div class="methodology-steps">
          <div class="step">
            <div class="step-number">01</div>
            <div class="step-content">
              <h4>Define Success</h4>
              <p>Establish clear, measurable criteria before building</p>
            </div>
          </div>
          
          <div class="step">
            <div class="step-number">02</div>
            <div class="step-content">
              <h4>Design Framework</h4>
              <p>Create comprehensive evaluation strategy</p>
            </div>
          </div>
          
          <div class="step">
            <div class="step-number">03</div>
            <div class="step-content">
              <h4>Build Infrastructure</h4>
              <p>Establish automated testing and monitoring</p>
            </div>
          </div>
          
          <div class="step">
            <div class="step-number">04</div>
            <div class="step-content">
              <h4>Iterate & Improve</h4>
              <p>Continuous development with constant evaluation</p>
            </div>
          </div>
        </div>
        
        <a href="introduction/evaluation-driven-methodology/" class="btn btn-primary">Learn the Methodology</a>
      </div>
      
      <div class="methodology-visual fade-in">
        <div class="diagram-container">
          <div class="process-flow">
            <div class="flow-node active">Requirements</div>
            <div class="flow-arrow"></div>
            <div class="flow-node active">Evaluation Design</div>
            <div class="flow-arrow"></div>
            <div class="flow-node active">Development</div>
            <div class="flow-arrow"></div>
            <div class="flow-node">Production</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="custom-section" id="getting-started">
  <div class="section-background-alt"></div>
  <div class="container">
    <div class="section-header">
      <h2 class="section-title" style="color: white;">Start Your Evaluation Journey</h2>
      <p class="section-subtitle" style="color: rgba(255,255,255,0.8);">Choose your path based on your role and experience</p>
    </div>
    
    <div class="pathways-grid">
      <div class="pathway-card zoom-in">
        <div class="pathway-header">
          <div class="pathway-icon">👩‍💻</div>
          <h3>Developers</h3>
        </div>
        <div class="pathway-content">
          <p>Build robust AI systems with integrated evaluation pipelines</p>
          <ul class="pathway-features">
            <li>Automated testing strategies</li>
            <li>Framework integrations</li>
            <li>CI/CD best practices</li>
          </ul>
        </div>
        <div class="pathway-cta">
          <a href="principles/testing-strategies/" class="btn btn-outline">Start Building</a>
        </div>
      </div>
      
      <div class="pathway-card zoom-in">
        <div class="pathway-header">
          <div class="pathway-icon">🤖</div>
          <h3>AI Engineers</h3>
        </div>
        <div class="pathway-content">
          <p>Master advanced evaluation techniques for complex AI systems</p>
          <ul class="pathway-features">
            <li>RAG evaluation methodology</li>
            <li>Model performance optimization</li>
            <li>Production monitoring</li>
          </ul>
        </div>
        <div class="pathway-cta">
          <a href="rag-evaluation/" class="btn btn-outline">Explore RAG</a>
        </div>
      </div>
      
      <div class="pathway-card zoom-in">
        <div class="pathway-header">
          <div class="pathway-icon">💼</div>
          <h3>Product Managers</h3>
        </div>
        <div class="pathway-content">
          <p>Understand evaluation metrics that drive business value</p>
          <ul class="pathway-features">
            <li>Business impact metrics</li>
            <li>A/B testing strategies</li>
            <li>Stakeholder communication</li>
          </ul>
        </div>
        <div class="pathway-cta">
          <a href="principles/quality-metrics/" class="btn btn-outline">Measure Impact</a>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="custom-section stats-section">
  <div class="container">
    <div class="stats-grid">
      <div class="stat-item fade-in">
        <div class="stat-number">50+</div>
        <div class="stat-label">Projects Evaluated</div>
      </div>
      
      <div class="stat-item fade-in">
        <div class="stat-number">95%</div>
        <div class="stat-label">Success Rate</div>
      </div>
      
      <div class="stat-item fade-in">
        <div class="stat-number">30+</div>
        <div class="stat-label">Team Members</div>
      </div>
      
      <div class="stat-item fade-in">
        <div class="stat-number">24/7</div>
        <div class="stat-label">Monitoring</div>
      </div>
    </div>
  </div>
</div>

<div class="custom-section cta-section">
  <div class="container">
    <div class="cta-content fade-in">
      <h2>Ready to Transform Your AI Evaluation?</h2>
      <p>Join teams already using our methodology to build better AI systems</p>
      <div class="cta-buttons">
        <a href="introduction/" class="btn btn-primary btn-large">Get Started Now</a>
        <a href="resources/manifest/" class="btn btn-secondary btn-large">Browse Resources</a>
      </div>
    </div>
  </div>
</div>

<script>
// Wait for DOM to be ready
document.addEventListener('DOMContentLoaded', function() {
  // Parallax Effect
  window.addEventListener('scroll', () => {
    const scrolled = window.pageYOffset;
    const parallaxLayers = document.querySelectorAll('.parallax-layer');
    
    parallaxLayers.forEach(layer => {
      const speed = parseFloat(layer.dataset.speed) || 0;
      const yPos = -(scrolled * speed);
      layer.style.transform = `translateY(${yPos}px)`;
    });
  });

  // Smooth Scrolling for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    });
  });

  // Intersection Observer for animations
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      }
    });
  }, observerOptions);

  // Observe all animated elements
  document.querySelectorAll('.fade-in, .zoom-in').forEach(el => {
    observer.observe(el);
  });

  // Stats Counter Animation
  let statsAnimated = false;
  const animateStats = () => {
    if (statsAnimated) return;
    statsAnimated = true;
    
    const stats = document.querySelectorAll('.stat-number');
    stats.forEach(stat => {
      const text = stat.textContent;
      let target = parseInt(text);
      const isPercentage = text.includes('%');
      const isPlus = text.includes('+');
      const hasSlash = text.includes('/');
      
      if (isNaN(target)) return;
      
      const increment = target / 100;
      let current = 0;
      
      const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
          stat.textContent = isPercentage ? `${target}%` : 
                            isPlus ? `${target}+` : 
                            hasSlash ? text : target;
          clearInterval(timer);
        } else {
          stat.textContent = Math.floor(current);
        }
      }, 20);
    });
  };

  // Trigger stats animation when section is visible
  const statsSection = document.querySelector('.stats-section');
  if (statsSection) {
    const statsObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          animateStats();
        }
      });
    }, { threshold: 0.3 });
    
    statsObserver.observe(statsSection);
  }
});
</script>