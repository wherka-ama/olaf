# Code2DFD CLI User Documentation

## Overview

Code2DFD is a command-line tool that automatically extracts Data Flow Diagrams (DFDs) with security-relevant annotations from microservice application source code. This tool analyzes Java-based microservice applications and generates comprehensive DFD visualizations and documentation.

## Prerequisites

### System Requirements
- Python 3.x
- Internet connection (for PlantUML PNG generation)
- Git (for repository cloning)

### Installation

1. **Clone the repository:**
   ```powershell
   git clone https://github.com/tuhh-softsec/code2DFD.git
   cd code2DFD
   ```

2. **Install dependencies:**
   ```powershell
   pip install -r requirements.txt
   ```

   Required packages:
   - Flask==2.1.2
   - plantuml==0.3.0
   - PyYAML==6.0
   - ruamel.base==1.0.0
   - PyDriller==2.6.0
   - lxml==5.3.0

## Command-Line Interface

### Basic Syntax
```powershell
python code2DFD.py [options]
```

### Available Options

#### Configuration
- `--config_path PATH`
  - Path to the configuration file to use
  - Can be replaced with individual CLI arguments
  - Example: `--config_path config/config.ini`

#### Repository Information
- `--repo_url URL`
  - URL to clone the repository from (can be local path)
  - Example: `--repo_url https://github.com/username/repository`
  - Example: `--repo_url C:\local\path\to\repository`

- `--repo_local_path PATH`
  - Location to clone repository to (without repository name)
  - Default: 'analysed_repositories' in current working directory
  - Example: `--repo_local_path C:\analysis\repositories`

- `--github_handle HANDLE`
  - GitHub repository handle (shorthand for GitHub URLs)
  - Format: username/repository
  - Example: `--github_handle apssouza22/java-microservice`

#### Analysis Settings
- `--commit HASH`
  - Analyze repository at specific commit
  - Accepts full or partial commit hash (will be truncated to 7 characters)
  - Repository returns to original state after analysis
  - Example: `--commit 056414c4c938e536f467a3f37532194b860d96a3`

- `--development_mode`
  - Switch on development mode (boolean flag)
  - Provides additional debug information
  - No value required (presence of flag enables it)

### Help
```powershell
python code2DFD.py --help
```

## Usage Examples

### 1. Using Configuration File
```powershell
# Basic usage with config file
python code2DFD.py --config_path config/config.ini
```

### 2. Analyzing GitHub Repository
```powershell
# Using GitHub handle (shorthand)
python code2DFD.py --github_handle apssouza22/java-microservice

# Using full GitHub URL
python code2DFD.py --repo_url https://github.com/apssouza22/java-microservice

# With specific commit
python code2DFD.py --github_handle apssouza22/java-microservice --commit 056414c4c938e536
```

### 3. Analyzing Local Repository
```powershell
# Local repository path
python code2DFD.py --repo_url C:\path\to\local\repository

# With custom output location
python code2DFD.py --repo_url C:\path\to\local\repository --repo_local_path C:\analysis\output
```

### 4. Development Mode
```powershell
# Enable development mode for detailed logging
python code2DFD.py --github_handle username/repository --development_mode

# Development mode with specific commit
python code2DFD.py --repo_url https://github.com/username/repository --commit abcd123 --development_mode
```

### 5. Override Config File Settings
```powershell
# CLI arguments take precedence over config file
python code2DFD.py --config_path config/config.ini --repo_url https://github.com/different/repository --development_mode
```

### 6. Batch Analysis (using provided script)
```bash
# For Unix/Linux systems (using analyze_all.sh)
./analyze_all.sh
```

## Configuration File

### Structure
The configuration file uses INI format with the following sections:

```ini
[Repository]
url = https://github.com/username/repository
local_path = path/to/local/directory

[Technology Profiles]
communication_techs_list = [("RabbitMQ", "rmq"), ("Kafka", "kfk"), ("RestTemplate", "rst"), ("FeignClient", "fgn"), ("Implicit Connections", "imp"), ("Database Connections", "dbc"), ("HTML", "html"), ("Docker-Compose", "dcm")]

[Analysis Settings]
development_mode = False
commit = 056414c4c938e536f467a3f37532194b860d96a3

[DFD]
# Empty section - reserved for future use
```

### Required Sections
1. **Repository**: Contains repository information
2. **Technology Profiles**: Defines communication technologies to analyze
3. **Analysis Settings**: Optional analysis parameters
4. **DFD**: Reserved section (currently empty)

### Sample Repositories
The default config file includes commented examples of analyzed repositories:
- apssouza22/java-microservice
- callistaenterprise/blog-microservices
- spring-petclinic/spring-petclinic-microservices
- sqshq/piggymetrics
- And many more...

## Output Files

Code2DFD generates multiple output files in the `code2DFD_output/PROJECT/` directory:

### 1. Visual Outputs
- **`PROJECT_uml.txt`**: UML diagram source code
- **`PROJECT_uml.png`**: Rendered PNG diagram (requires internet connection)

### 2. Machine-Readable Outputs
- **`PROJECT_json_architecture.json`**: Complete DFD in JSON format
- **`PROJECT_edges.json`**: Information flows only
- **`PROJECT.py`**: CodeableModels format (requires CodeableModels library)

### 3. Human-Readable Outputs
- **`PROJECT_results.txt`**: Textual description of microservices, external entities, and information flows

### 4. Analysis Metadata
- **`PROJECT_traceability.json`**: Traceability information linking DFD elements to source code
- **`code2DFD_output/logs/`**: Analysis logs with timestamps

## Error Handling

### Common Issues

1. **Missing Dependencies**
   ```
   ModuleNotFoundError: No module named 'pydriller'
   ```
   **Solution**: Install requirements: `pip install -r requirements.txt`

2. **Repository Access**
   ```
   AttributeError: Parameter [Repository][url] must be provided
   ```
   **Solution**: Provide repository URL via `--repo_url` or `--github_handle`

3. **Network Issues**
   - PNG generation may fail without internet connection
   - Repository cloning may fail with network issues
   - PlantUML rendering requires external service access

### Best Practices

1. **Repository URLs**: Ensure repositories are publicly accessible or provide proper authentication
2. **Local Paths**: Use absolute paths to avoid navigation issues
3. **Commit Hashes**: Use at least 7-character commit hashes for specificity
4. **Output Directory**: Ensure sufficient disk space for analysis outputs
5. **Development Mode**: Use for debugging and detailed analysis information

## Parameter Precedence

When both configuration file and CLI arguments are provided:
1. CLI arguments take precedence over config file settings
2. Default values are used when neither is specified
3. Required parameters must be provided either way

## Advanced Usage

### RESTful API Service
```powershell
# Start Flask API server
python flask_code2DFD.py

# Access via HTTP requests
# GET localhost:5001/dfd?url=https://github.com/username/repository
# GET localhost:5001/dfd?url=https://github.com/username/repository&commit=abcd123
```

### Integration with Other Tools
- Use JSON outputs for further processing
- Import CodeableModels format for advanced visualization
- Parse traceability information for source code mapping
- Integrate logs into CI/CD pipelines

## Technology Support

Code2DFD automatically detects and analyzes:
- **Communication Technologies**: RabbitMQ, Kafka, RestTemplate, FeignClient
- **Databases**: Database connections and interactions
- **Infrastructure**: Docker, Docker-Compose configurations
- **Web Technologies**: HTML, REST APIs
- **Service Discovery**: Eureka, Consul
- **Security**: OAuth, SSL, encryption configurations
- **Monitoring**: Prometheus, Grafana, logging systems

## Troubleshooting

### Verification Steps
1. Check Python version: `python --version`
2. Verify dependencies: `pip list`
3. Test with sample repository: `python code2DFD.py --github_handle apssouza22/java-microservice`
4. Check output directory permissions
5. Verify internet connectivity for PNG generation

### Debug Information
- Use `--development_mode` for detailed logging
- Check `code2DFD_output/logs/` for analysis logs
- Verify repository accessibility and structure
- Ensure target repository contains Java microservice code

For additional support, refer to the [GitHub repository](https://github.com/tuhh-softsec/code2DFD) or the academic publication for detailed methodology information.
