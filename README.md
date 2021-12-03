# CCS Prototype Kit

The clever folks over at the Government Digital Service (GDS) have created a [prototype kit](https://github.com/alphagov/govuk-prototype-kit) which allows for the rapid development of prototypes for government websites.
This project adds a slight extension to the original which allows users to create their prototypes using CCS stylings.

Apart from the additional CCS assets, this project is identical and kept up to date with [GOV.UK Prototype Kit](https://github.com/alphagov/govuk-prototype-kit) and all credit goes to them for making this project work.
Because of this, you can use the documentation found on the [GOV.UK Prototype Kit site](https://govuk-prototype-kit.herokuapp.com/docs) when working with this project.

 ## About the GOV.UK Prototype Kit

The Prototype Kit provides a simple way to make interactive prototypes that look like pages on GOV.UK and [CCS](https://www.crowncommercial.gov.uk/). These prototypes can be used to show ideas to people you work with, and to do user research.

Read the [project principles](https://govuk-prototype-kit.herokuapp.com/docs/principles) that GDS have in mind for this kit.

## Make sure prototypes are password-protected

If you publish your prototypes online, they **must** be protected by a [username and password](https://govuk-prototype-kit.herokuapp.com/docs/publishing-on-heroku). This is to prevent members of the public finding prototypes and thinking they are real services.

You must protect user privacy at all times, even when using prototypes. Prototypes made with the kit look like GOV.UK, but do not have the same security provisions. Always make sure you are handling user data appropriately.

## Installation instructions
To install this kit, you can follow the same instructions that are described in the GOV.UK documentation.
The only difference is that you want to be installing from [this GitHub repository](https://github.com/Crown-Commercial-Service/ccs-prototype-kit) instead of the GOV.UK one.

- [Installation guide for developers (technical)](https://govuk-prototype-kit.herokuapp.com/docs/install/developer-install-instructions)

- [Installation guide for new users (non technical)](https://govuk-prototype-kit.herokuapp.com/docs/install/introduction)

## Adding CCS frontend assets
CCS has a repository which contains assets used on the CCS website called [CCS-Frontend-Kit](https://github.com/Crown-Commercial-Service/CCS-Frontend-Kit/).
These are the assets we are adding into the project to be used when creating a prototype.

We use a script which adds the `CCS-Frontend-Kit` into the node package and then adds all the relevant assets into the apps assets folder.
The purpose for doing this via a script was to make the process repeatable in case updates happen to `CCS-Frontend-Kit` or `GOV.UK Prototype Kit` which affect the build.

The script works by doing the following steps:
- Removing existing CCS assets (if they exists). This allows for a clean re-adding of the `CCS-Frontend-Kit` in the situation where the assets have been updated/changed.
- Install the `ccs-frontend-kit` package using `npm`
- Copy the following static CCS assets to the `app/assets` folder:
  - Images
  - Fonts
  - SVGs
- Import `styles.scss` into the existing `application.scss`. As the assets are compiled into the `public/` folder in a single file, we do not need to copy all stylesheet files into the main application as the import will take care of this for us.
- Import the JavaScript files and add them to the `app/views/includes/scripts.html` file so they are properly loaded in the application. Note, we do not import `JQuery` as it is already a part of the initial GOV.UK Prototype Kit project.

And that is all there is to this project.
As previously stated, the hard work was done over at the Government Digital Service so any credit belongs to them.

This project only adds the CCS assets so that you can use them out of the box.
<!-- Add propper link -->
You can see an example of a page using the CCS assets [here](https://ccs-prototype-kit.herokuapp.com/ccs/example).

## Support
As this is an extension of the GOV.UK Prototype Kit, which is maintained by the Government Digital Service. If you’ve got a question or need support that is related to using the CCS assets, you can:
<!-- Add propper link -->
* email [ccs-prototype-kit@crowncommercial.gov.uk](mailto:some.email@crowncommercial.gov.uk).
* [view known issues on GitHub](https://github.com/Crown-Commercial-Service/ccs-prototype-kit/issues)

For any other issues related to using the prototype kit, please [contacts GDS](https://github.com/alphagov/govuk-prototype-kit#support).
If you are unsure where to send your question, then contact CCS and we can help redirect the request to GDS if necessary.

## Contributing

You can contribute to the original GOV.UK Prototype Kit, by viewing the information [in this section](https://github.com/alphagov/govuk-prototype-kit#contributing) of the project README.

As this project is for internal use within CCS we are not currently accepting code contributions.
However, if you have an idea on how we can improve this project, feel free to [create an issue](https://github.com/Crown-Commercial-Service/ccs-prototype-kit/issues).

### Security

If you have discovered a security vulnerability in this code, we appreciate your help in disclosing it to us in a responsible manner.

Please follow the [CCS vulnerability reporting steps](https://www.crowncommercial.gov.uk/about-ccs/vulnerability-disclosure-policy/), giving details of any issue you find. Appropriate credit will be given to those reporting confirmed issues.


