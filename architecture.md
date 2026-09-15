```mermaid
graph TD
    %% Define nodes
    subgraph Internet ["Internet"]
        User([User/Admin Workstation])
    end

    subgraph AWS_VPC ["AWS VPC"]
        subgraph Public_Subnet ["Public Subnet"]
            ALB[Application Load Balancer]
            BastionAnsible["Bastion & Ansible Controller"]
            IGW(Internet Gateway)
        end

        subgraph App_Subnet ["Private Subnet (App Layer)"]
            FE1[Frontend Server 1 EC2]
            FE2[Frontend Server 2 EC2]
        end

        subgraph DB_Subnet ["Private Subnet (DB Layer)"]
            MySQL[(MySQL Database EC2)]
        end
    end

    %% Define connections and traffic flow
    User -- "HTTP/HTTPS (Port 80/443)" --> ALB
    User -- "SSH (Port 22)" --> BastionAnsible
    
    IGW -.-> ALB
    IGW -.-> BastionAnsible
    
    %% ALB to Frontend
    ALB -- "HTTP (Port 80)" --> FE1
    ALB -- "HTTP (Port 80)" --> FE2
    
    %% Management & Configuration
    BastionAnsible -- "SSH (Port 22)" --> FE1
    BastionAnsible -- "SSH (Port 22)" --> FE2
    BastionAnsible -- "SSH (Port 22)" --> MySQL
    
    %% App to DB
    FE1 -- "MySQL (Port 3306)" --> MySQL
    FE2 -- "MySQL (Port 3306)" --> MySQL

    %% Styling
    classDef client fill:#f9f,stroke:#333,stroke-width:2px;
    classDef vpc fill:#e1f5fe,stroke:#0277bd,stroke-width:2px;
    classDef subnet fill:#b3e5fc,stroke:#0277bd,stroke-width:1px,stroke-dasharray: 5 5;
    classDef ec2 fill:#fff9c4,stroke:#fbc02d,stroke-width:1px;
    classDef db fill:#c8e6c9,stroke:#388e3c,stroke-width:1px;
    classDef mgmt fill:#e0f2f1,stroke:#009688,stroke-width:2px;
    classDef alb fill:#ffe0b2,stroke:#fb8c00,stroke-width:2px;

    class User client;
    class AWS_VPC vpc;
    class Public_Subnet,App_Subnet,DB_Subnet subnet;
    class FE1,FE2 ec2;
    class MySQL db;
    class BastionAnsible mgmt;
    class ALB alb;
    ```