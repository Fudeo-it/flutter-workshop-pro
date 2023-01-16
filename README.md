# flutter-workshop-pro

Sono a disposizione del corso [Workshop Pro](https://edu.fudeo.it/course/7237777e-2381-4e7b-908e-fb644bea36ed/overview) degli endpoint per sviluppare l'applicazione assieme al tutor.

Di seguito una breve documentazione degli endpoint disponibili, parametri e risposta.
Da ricordare che tutti gli endpoint si aspettano JSON e ritornano JSON.

## Registrazione

#### Endpoint: [POST] https://servatedb.vercel.app/api/fudeo-flutter-workshop-pro/register

Nome parametro | Tipo 
--- | --- 
name | String
email | String
password | String

#### Errore:

Status | Risposta (come stringa) | Descrizione
--- | --- | --- 
403 | ERROR_ALREADY_REGISTERED | Un account con la email indicata esiste già

#### Successo:

```typescript
{
  name: String,
  email: String,
  token: String,
  passwords: {
    name: String,
    email: String,
    password: String,
    website: String,
  }[]
}
```

## Login

#### Endpoint: [POST] https://servatedb.vercel.app/api/fudeo-flutter-workshop-pro/login

Nome parametro | Tipo 
--- | --- 
email | String
password | String

#### Errore:

Status | Risposta (come stringa) | Descrizione
--- | --- | --- 
404 | ERROR_NOT_FOUND | Un account con la email indicata non è stato trovato
403 | ERROR_PASSWORD_NO_MATCH | La password per l'email usata non è valida

#### Successo:

```typescript
{
  name: String,
  email: String,
  token: String,
  passwords: {
    name: String,
    email: String,
    password: String,
    website: String,
  }[]
}
```


## Tutte le passwords

#### Endpoint: [GET] https://servatedb.vercel.app/api/fudeo-flutter-workshop-pro/passwords

Nome header | Formato 
--- | --- 
Authorization | Bearer [JWT]

#### Errore:

Status | Risposta (come stringa) | Descrizione
--- | --- | --- 
404 | ERROR_NOT_AUTHORIZED | La richiesta non contiene una JWT valida

#### Successo:

```typescript
{
  passwords: {
    name: String,
    email: String,
    password: String,
    website: String,
  }[]
}
```


## Aggiorna le passwords

#### Endpoint: [PATCH/POST] https://servatedb.vercel.app/api/fudeo-flutter-workshop-pro/passwords

Nome header | Formato 
--- | --- 
Authorization | Bearer [JWT]

Nome parametro | Tipo 
--- | --- 
passwords | JSON

#### Errore:

Status | Risposta (come stringa) | Descrizione
--- | --- | --- 
404 | ERROR_NOT_AUTHORIZED | La richiesta non contiene una JWT valida

#### Successo:

```typescript
{
  passwords: {
    name: String,
    email: String,
    password: String,
    website: String,
  }[]
}
```
