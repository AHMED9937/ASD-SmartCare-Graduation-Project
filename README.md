# Autism Spectrum Disorder Smart Care

> A smart integrated platform and application for autism support, developed as a Bachelor of Computer Science graduation project at Suez Canal University (Academic Year 2024/2025).

---

## Table of Contents

* [Acknowledgement](#acknowledgement)
* [Abstract](#abstract)
* [Introduction](#introduction)
* [Features](#features)
* [Architecture](#architecture)
* [Technologies](#technologies)
* [Project Structure](#project-structure)
* [Getting Started](#getting-started)
* [Team & Supervisor](#team--supervisor)
* [License](#license)
* [Contact](#contact)

---

## Acknowledgement

We extend our sincere gratitude to Dr. Magdy Shayboub Ali for continuous guidance, the Faculty of Computers and Informatics at Suez Canal University for resources, our families for support, and all professionals and parents who shared insights on autism, making this project possible. fileciteturn1file0

## Abstract

Autism Spectrum Disorder (ASD) is a developmental condition affecting communication and social interaction. Early diagnosis and support improve quality of life. ASD SmartCare integrates an AI‑powered chatbot for preliminary screening and severity assessment, recommends specialists, enables online consultations, and provides secure communication with healthcare professionals. It also offers educational resources, medication guidance, and access to charitable support programs, empowering families with a unified, intelligent platform. fileciteturn1file0

## Introduction

ASD SmartCare addresses fragmented autism care by offering:

* **AI‑Based Screening & Severity Detection**: Conversational NLP chatbot for early assessment
* **Specialist Recommendation & Booking**: Personalized suggestions and in‑app scheduling
* **Real‑Time Chat**: Secure messaging between parents and professionals
* **Progress Tracking**: Longitudinal monitoring of developmental milestones
* **Educational Resources**: Curated videos, articles, and interactive guides
* **Pharmacy & Medication Guidance**: Drug library with dosage and side‑effect information
* **Charity Integration**: Connection to NGOs offering free or subsidized support

This all‑in‑one ecosystem bridges gaps in diagnosis, treatment, and ongoing care. fileciteturn1file0

## Features

1. **Conversational AI Screening**: Hybrid chatbot using NLP and ML models for ASD detection and severity classification.
2. **Specialist Directory & Booking**: View doctor profiles, check availability, and book appointments.
3. **Secure Messaging**: Real‑time chat with pediatric neurologists, psychologists, and therapists.
4. **Child Progress Dashboard**: Session notes and progress reports updated by clinicians.
5. **Educational Library**: Tips, tutorials, and interactive tools for parents.
6. **Medication Module**: Filterable drug library and pharmacy locator.
7. **Charity Support Portal**: Apply for free medication and financial aid programs. fileciteturn1file0

## Architecture

* **Frontend**: Flutter mobile application (Android & iOS) and React.js web SPA.
* **Backend**: Node.js with Express.js for RESTful services; FastAPI Python microservice for ML inference.
* **Database**: MongoDB (chat history, sessions) and PostgreSQL (relational data schema).
* **AI Models**: KNeighborsClassifier for ASD detection (97% accuracy); CatBoostClassifier for severity (97.5% accuracy).
* **Deployment**: Azure Web Apps for ML services; Vercel for backend; static hosting for web client. fileciteturn1file0

## Technologies

| Layer       | Tools & Frameworks                                   |                       |
| ----------- | ---------------------------------------------------- | --------------------- |
| Frontend    | Flutter, React.js, Figma                             |                       |
| Backend     | Node.js, Express.js, FastAPI                         |                       |
| Database    | MongoDB, PostgreSQL                                  |                       |
| NLP & ML    | Python, NLTK, Scikit‑learn, CatBoost, OpenAI Whisper |                       |
| Auth & Chat | JWT, Firebase Auth, Socket.IO                        |                       |
| APIs        | Google Maps, Charity Info API                        |                       |
| Deployment  | Azure, Vercel, Firebase                              | fileciteturn1file0 |

## Project Structure

```text
/asd-smartcare
├── frontend_flutter      # Flutter mobile app source
├── frontend_web          # React.js web client
├── backend_api           # Node.js + Express server
├── ml_service            # FastAPI microservice for ML models
├── database_scripts      # Schema definitions & migration
├── docs                  # ER diagrams, DFDs, design specs
└── README.md             # Project documentation
```


## Team & Supervisor

* **Project Supervisor**: Dr. Magdy Shayboub Ali (Associate Professor)
* **Team Members**:

  * Ahmed Farouk Mahmoud
  * Khaled Elmorse Hafez
  * Ahmed Abdelwahab Mahmoud
  * Ahmed Mohamed Faisal
  * Ahmed Mohamed Elsayed
  * Mayada Gamal Abdel Hamid
  * Dalia Abdalla Elsayed

