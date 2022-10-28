import * as React from 'react'

const PrivacyPolicy: React.FC = () => {
  const [open, setOpen] = React.useState(false);
  const handleOpen = () => setOpen(true);
  const handleClose = () => setOpen(false);

  return (
    <div>
      <span className="nav-link" onClick={handleOpen}>Privacy Policy</span>
      {open?
        <div className="modal-wrapper">
          <div className="modal-backdrop" onClick={handleClose} />
          <div className="modal">
            <div className="codicon codicon-close modal-close" onClick={handleClose}></div>
            <h2>Privacy Policy</h2>

            <p>Our server collects metadata (such as IP address, browser, operating system)
            and the data that the user enters into the editor. The data is exclusively used to
            compute the Lean output and display it to the user. The information will be stored
            as long as the user stays on our website and will be deleted immediately afterwards.
            Our server is located in Germany.</p>

            <p><strong>Contact information:</strong><br />
              Alexander Bentkamp<br />
              Mathematisches Institut der Heinrich-Heine-Universität Düsseldorf<br />
              Universitätsstr. 1<br />
              40225 Düsseldorf<br />
              Germany<br />
              <a href="mailto:alexander.bentkamp@hhu.de">alexander.bentkamp@hhu.de</a>

            </p>
          </div>
        </div> : null}
    </div>
  )
}

export default PrivacyPolicy
